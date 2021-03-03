import requests
from bs4 import BeautifulSoup
import csv

## Scrape EELS Edge info from eels.info

headers = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET',
    'Access-Control-Allow-Headers': 'Content-Type',
    'Access-Control-Max-Age': '3600',
    'User-Agent': 'Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:52.0) Gecko/20100101 Firefox/52.0'
    }

url = "https://eels.info/atlas"
req = requests.get(url, headers)
soup = BeautifulSoup(req.content, 'html.parser')

trs = soup.find_all("tr", {"class": ["odd","even"]})


with open('eels.csv', 'w', newline='') as csvfile:
    csvwriter = csv.writer(csvfile, delimiter=' ',
                            quotechar='|', quoting=csv.QUOTE_MINIMAL)
    csvwriter.writerow(['Z','Symbol','K','L1','L2','L3','M1','M2','M3','M4','M5','N1','N23','N4','N5','N6','N7','O1','O23','O45'])

    for tr in trs:
        l = tr.find('a').get('href')
        z = tr.find("td",{"class":"views-field-field-element-atomic-number"}).text.strip()
        s = tr.find("td",{"class":"views-field-field-element-symbol"}).text.strip()


        url = "https://eels.info" + l
        req = requests.get(url, headers)
        soup_elem = BeautifulSoup(req.content, 'html.parser')

        edges = soup_elem.find_all('div',{'class': ['edge-row']})

        K  = 'NaN'
        L1 = 'NaN'
        L2 = 'NaN'
        L3 = 'NaN'
        M1 = 'NaN'
        M2 = 'NaN'
        M3 = 'NaN'
        M4 = 'NaN'
        M5 = 'NaN'
        N1 = 'NaN'
        N1 = 'NaN'
        N23 = 'NaN'
        N4 = 'NaN'
        N5 = 'NaN'
        N6 = 'NaN'
        N7 = 'NaN'
        O1 = 'NaN'
        O23 = "NaN"
        O45 = 'NaN'



        for edge in edges:
            edge_name = edge.find('span',{'class': ['edge-edge']}).text
            edge_energy =  edge.find('span',{'class': ['edge-energy']}).text

            if edge_name == 'K' :
                K = edge_energy
            elif edge_name == 'L1' :
                L1 = edge_energy
            elif edge_name == 'L2' :
                L2 = edge_energy
            elif edge_name == 'L3' :
                L3 = edge_energy
            elif edge_name == 'L23' :
                L2 = edge_energy
                L3 = edge_energy
            elif edge_name == 'M1' :
                M1 = edge_energy
            elif edge_name == 'M2' :
                M2 = edge_energy
            elif edge_name == 'M3' :
                M3 = edge_energy
            elif edge_name == 'M23' :
                M2 = edge_energy
                M3 = edge_energy
            elif edge_name == 'M4' :
                M4 = edge_energy
            elif edge_name == 'M5' :
                M5 = edge_energy
            elif edge_name == 'M45' :
                M4 = edge_energy
                M5 = edge_energy
            elif edge_name == 'N1' :
                N1 = edge_energy
            elif edge_name == 'N23' :
                N23 = edge_energy
            elif edge_name == 'N4' :
                N4 = edge_energy
            elif edge_name == 'N5' :
                N5 = edge_energy
            elif edge_name == 'N45' :
                N4 = edge_energy
                N5 = edge_energy
            elif edge_name == 'N6' :
                N6 = edge_energy
            elif edge_name == 'N7' :
                N7 = edge_energy
            elif edge_name == 'N67' :
                N6 = edge_energy
                N7 = edge_energy
            elif edge_name == 'O1' :
                O1 = edge_energy
            elif edge_name == 'O23' :
                O23 = edge_energy
            elif edge_name == 'O45' :
                O45 = edge_energy
            else :
                print("Something Wrong at " + z + " " + edge_name)

        csvwriter.writerow( [z, s, K, L1, L2, L3, M1, M2, M3, M4, M5,N1,N23,N4,N5,N6,N7,O1,O23,O45])
        print(z)

