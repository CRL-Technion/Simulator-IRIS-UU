function LoadObjModel(fname)

fid = fopen(fname);

    pos.clear();
    texture.clear();
    normal.clear();
    t_i.clear();
    t_i.clear();
    n_i.clear();

    String line;
    RealNum x, y, z;
    Idx U, V;
    Idx idx, n;
    while (std::getline(fin, line)) {
        auto key = line.substr(0, 2);
        if (key == "v ") {
            // Check v for vertices.
            std::istringstream v(line.substr(2));
            v >> x >> y >> z;
            pos.emplace_back(x, y, z);
        }
        else if (key == "vt") {
            // Check for texture co-ordinate
            std::istringstream v(line.substr(3));
            v >> U >> V;
            texture.emplace_back(U, V);
        }
        else if (key == "vn") {
            std::istringstream v(line.substr(3));
            v >> x >> y >> z;
            normal.emplace_back(x, y, z);
        }
        else if(key == "f ") {
            std::istringstream v(line.substr(2));
            String field0, field1;
            std::vector<String> fields;
            while (std::getline(v, field0, ' ')) {
                std::istringstream u(field0);
                n = 0;
                while (std::getline(u, field1, '/')) {
                    n++;
                    if (field1.empty()) {
                        continue;
                    }
                    std::istringstream w(field1);
                    w >> idx;
                    if (n == 1) {
                        v_i.push_back(--idx);
                    }
                    else if (n == 2) {
                        t_i.push_back(--idx);
                    }
                    else {
                        n_i.push_back(--idx);
                    }
                }
            }
        }
    }

    std::cout << "Vertices in model: " << pos.size() << std::endl;
    std::cout << "Faces in model: " << v_i.size()/3 << std::endl;


end