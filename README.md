<p align="center">
  <img alt="Coding" width="100%" src="./KxbHmvL3MGcctzlfdX.webp">
</p>

# Welcome to my GitHub Profile! 👋

```cpp
#include <iostream>
#include <string>
#include <vector>

/**
 * @class Software_developer
 * @brief Specializes in C/C++ and Machine Learning.
 */
class Software_developer
{
public:
  Software_developer() noexcept : 
        name("Ruykaji"), 
        roles({ "C/C++ Developer", "Machine Learning Enthusiast" }),
        languages({ "C", "C++", "Python" }) {};

  /**
   * @brief Displays the developer's bio.
   */
  void
  display_bio() const noexcept
  {
    std::cout << "👋 Hi, I’m Ilya Shafeev aka Ruykaji\n";
    std::cout << "👀 I’m interested in complex problem solving and data analysis\n";
    std::cout << "🌱 Advancing my skills in C/C++ and machine learning\n";
    std::cout << "💞️ Looking to collaborate on projects that combine C++ efficiency with machine learning\n";
    std::cout << std::flush;
  }

private:
  std::string name;
  std::vector<std::string> roles;
  std::vector<std::string> languages;
};

int
main()
{
  Software_developer dev;
  dev.display_bio();

  return 0;
}
```
# Stats

<p align="center">
  <a href="https://github.com/anuraghazra/github-readme-stats">
    <img align="center" height=215 align="center" src="https://github-readme-stats.vercel.app/api?username=ruykaji&show_icons=true&theme=tokyonight" />
  </a>
  <a href="https://github.com/anuraghazra/convoychat">
    <img align="center" height=215 align="center" src="https://github-readme-stats.vercel.app/api/top-langs/?username=ruykaji&show_icons=true&theme=tokyonight&layout=compact&card_width=320" />
  </a>
</p>