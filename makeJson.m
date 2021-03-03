fid = fopen('elements.json','w');
fprintf(fid, jsonencode( parseElements ) );
fclose(fid);
