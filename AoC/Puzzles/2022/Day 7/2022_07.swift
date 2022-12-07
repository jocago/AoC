
import Foundation

struct p2022_7: Puzzle {
    //var data = testInput.parseToStringArray()
    var data = input_2022_7.parseToStringArray()
    var runPart = 2
        
    func cd(cwd: Directory, param: String, root: Directory) -> Directory {
        if param == "/" { return root}
        if param == ".." {
            guard cwd.name != "/" else { return root }
            return cwd.parent!
        }
        for dir in cwd.subdirectories {
            if dir.name == param { return dir }
        }
        // assume here that the param has not been created as a subdir
        let new_dir = Directory(name: param, parent: cwd)
        return new_dir
    }
    
    class File {
        var name: String
        var size: Int
        
        init(name: String, size: Int) {
            self.name = name
            self.size = size
        }
    }

    class Directory: Equatable {
        let id = UUID().uuidString
        var name: String
        weak var parent: Directory? // only root
        var subdirectories: [Directory] = []
        var files: [File] = []
        
        init(name: String, parent: Directory?) {
            self.name = name
            self.parent = parent
        }
        
        static func == (lhs: Directory, rhs: Directory) -> Bool {
            return lhs.id == rhs.id
        }
        
        func get_size() -> Int {
            var size = 0
            self.subdirectories.forEach { dir in size += dir.get_size() }
            self.files.forEach { file in size += file.size }
            return size
        }
        
        func add_dir(name: String) {
            var already_exists = false
            for dir in self.subdirectories {
                if dir.name == name { already_exists = true }
            }
            if !already_exists {
                self.subdirectories.append(Directory(name: name, parent: self))
            }
            
        }
        
        func add_file(name: String, size: Int) {
            var already_exists = false
            for file in self.files {
                if file.name == name { already_exists = true }
            }
            if !already_exists {
                self.files.append(File(name: name, size: size))
            }
        }
        
        func get_directories() -> [Directory] {
            var dirs =  self.subdirectories
            self.subdirectories.forEach { dir in
                if !dirs.contains(dir) { dirs.append(dir) }
                dir.get_directories().forEach { sdir in
                    if !dirs.contains(sdir) { dirs.append(sdir) }
                }
            }
            return dirs
        }
    }
    
    func load_fs(root: Directory) -> Directory {
        var cwd = root
        for l in data {
            let lp = l.split(separator: " ")
            if lp.count == 3 { // cd command
                cwd = cd(cwd: cwd, param: String(lp[2]), root: root)
            } else {
                if lp[0] == "$" {} // nothing needed  for ls
                else if lp[0] == "dir" { cwd.add_dir(name: String(lp[1])) }
                else { cwd.add_file(name: String(lp[1]), size: Int(lp[0])!) }
            }
        }
        return root
    }
    
    func part1() -> Any {
        let target = 100000
        let root = load_fs(root: Directory(name: "/", parent: nil))
        var size = 0
        root.get_directories().forEach { dir in
            let dirsize = dir.get_size()
            if dirsize <= target {
                size += dirsize
            }
        }
        return size
    }

    func part2() -> Any {
        let root = load_fs(root: Directory(name: "/", parent: nil))
        let required_space = 70000000 - 30000000
        let needed_space = root.get_size() - required_space
        var candidate_dir_space: [Int] = []
        root.get_directories().forEach { dir in
            if dir.get_size() >= needed_space { candidate_dir_space.append(dir.get_size()) }
        }
        return candidate_dir_space.min()!
    }
}


/*
 Pt 1 test target: 95437
 pt 2 test target: 24933642
 */
fileprivate let testInput = Data(raw: """
$ cd /
$ ls
dir a
14848514 b.txt
8504156 c.dat
dir d
$ cd a
$ ls
dir e
29116 f
2557 g
62596 h.lst
$ cd e
$ ls
584 i
$ cd ..
$ cd ..
$ cd d
$ ls
4060174 j
8033020 d.log
5626152 d.ext
7214296 k
""")


