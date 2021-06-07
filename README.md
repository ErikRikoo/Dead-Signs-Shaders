# Dead Signs Shader - Unity
_The package which contains the shader developped 
for the video game [Dead Signs](https://www.deadsigns.fr/)_

## Installation
To install this package you can do one of this:
- Using Package Manager Window
    - Opening the Package Manager Window: Window > Package Manager
    - Wait for it to load
    - Click on the top left button `+` > Add package from git URL
    - Copy paste the [repository link](https://github.com/ErikRikoo/Dead-Signs-Shaders.git)
    - Press enter

- Modifying manifest.json file
Add the following to your `manifest.json` file (which is under your project location in `Packages` folder)
```json
{
  "dependancies": {
    ...
    "com.rikoo.dead-signs-shader": "https://github.com/ErikRikoo/Dead-Signs-Shaders.git",
    ...
  }
}
```

## Updating
Sometimes Unity has some hard time updating git dependencies so when you want to update the package, 
follow this steps:
- Go into `package-lock.json` file (same place that `manifest.json` one)
- It should look like this:
```json
{
  "dependencies": {
    ...
    "com.rikoo.dead-signs-shader": {
      "version": "https://github.com/ErikRikoo/Dead-Signs-Shaders.git",
      "depth": 0,
      "source": "git",
      "dependencies": {},
      "hash": "hash-number-there"
    },
    ...
}
```
- Remove the _"com.rikoo.dead-signs-shader"_ and save the file
- Get back to Unity
- Let him refresh
- Package should be updated

## How does it work
Just include it and test the shaders 😄

#### Old TV Effect
For this effect, we tried to reproduce an old tv screen while running 
some [post processing](https://github.com/ErikRikoo/Unity-UI-Post-Process.git) stuff on wolrd space UI.
It gave multiple effects:
- Horizontal Lines to simulate pixels while drawing some lines on top of the texture
    - **Vertical pixel count** which allows you to specify an amount of lines (not really precise)
    - **Vertical Pixel Intensity** gives you the ability to make the lines hard or smoother
- [Vignetting](https://en.wikipedia.org/wiki/Vignetting) 
    - **Vignette Color** which allows you to specify which color you want for the vignette, defaulted to black
    - **Vignette Intensity**
    - **Vignette Roundness**
    - ***Vignette Smoothness*
- Distorsion which deforms the image as there was some glass on it
    - **Distorsion Intensity** is there to give the percentage of distorsion, 
    it can be negative to inverse the effect
    
#### Highlight Effect
This shader can be used as on overlay over an object to show that it is interactible. 
It looks like effect we can see un The Last Of Us and has been inspired by 
[febucci tutorial](https://www.febucci.com/2019/04/pickable-objects-shader/).
You can configure the speed of the effect and the highlight color.



## Suggestions
Feel free to suggest features by creating an issue, any idea is welcome !
