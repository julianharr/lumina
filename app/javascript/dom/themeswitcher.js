const themeSwitcher = () => {
const themeSwitch = document.querySelector(".theme-button");
if(!themeSwitch) return;
themeSwitch.addEventListener("click", function() {
    document.body.classList.toggle("light-theme");
  });
}

export { themeSwitcher };
