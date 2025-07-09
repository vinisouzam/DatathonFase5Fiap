# %%
import json
import pandas as pd
import os

class DataConverter:
    """Class to convert the json file into parquet format."""
    
    def __init__(self, input_path: os.PathLike, output_path: os.PathLike):
        self.input_path = input_path
        self.output_path = output_path

        print('Iniciado leitura do arquivo json...')
        self.data_raw = self.get_data()

        print('Iniciada conversao do json para dataframe...')
        self.data_df = self.convert_to_df(self.data_raw)

        print('Iniciada exportacao do dataframe para parquet...')
        self.export_to_parquet()

        print('Finalizado!')

    def get_data(self):
        with open(self.input_path, "r") as f:
            data_raw = json.load(f)

        return data_raw

    def convert_to_df(self, data_raw):
        """Convert JSON dict to DataFrame with flattening."""
        df = pd.DataFrame()
        for i in data_raw.keys():
            temp = pd.json_normalize(data_raw[i], record_prefix=False, sep='.')
            temp.insert(0, 'id', i)
            temp.set_index('id', inplace=True)
            df = pd.concat([df, temp], ignore_index=False)

        return df

    def export_to_parquet(self):
        """Export DataFrame to parquet."""
        self.data_df.to_parquet(path=self.output_path, engine='pyarrow')
        print('Exportado com sucesso para parquet!')

# %%
current_path = os.path.abspath(__file__)
current_dir = os.path.dirname(current_path)
parent_dir = os.path.dirname(current_dir)

mybase_path = os.path.join(parent_dir,'data')
# %%

if __name__ == "__main__":

    input_path = [
        os.path.join(*[mybase_path,'raw','vagas.json']),
        os.path.join(*[mybase_path,'raw','applicants.json']),
        os.path.join(*[mybase_path,'raw','prospects.json'])
        # "/app/data/raw/vagas.json",
        # "/app/data/raw/applicants.json",
        # "/app/data/raw/prospects.json"
    ]
    output_path = [
        os.path.join(*[mybase_path,'processed','vagas.parquet']),
        os.path.join(*[mybase_path,'processed','applicants.parquet']),
        os.path.join(*[mybase_path,'processed','prospects.parquet'])
        # "/app/data/processed/vagas.parquet",
        # "/app/data/processed/applicants.parquet",
        # "/app/data/processed/prospects.parquet"
    ]
    
    for i in range(len(input_path)):
        DataConverter(input_path=input_path[i], output_path=output_path[i])
