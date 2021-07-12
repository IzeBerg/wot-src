package net.wg.gui.components.controls
{
   import flash.display.MovieClip;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   
   public class ScrollThumb extends SoundButton
   {
       
      
      public var icon:MovieClip;
      
      public var states:MovieClip;
      
      public function ScrollThumb()
      {
         super();
      }
      
      override public function gotoAndPlay(param1:Object, param2:String = null) : void
      {
         if(this.states)
         {
            this.states.gotoAndPlay(param1);
         }
         if(this.icon)
         {
            this.icon.gotoAndPlay(param1);
         }
      }
      
      override public function gotoAndStop(param1:Object, param2:String = null) : void
      {
         if(this.states)
         {
            this.states.gotoAndStop(param1);
         }
         if(this.icon)
         {
            this.icon.gotoAndStop(param1);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         if(this.states)
         {
            _labelHash = UIComponent.generateLabelHash(this.states);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         initSize();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.states.width = _width;
            this.states.height = _height;
            this.icon.y = _height >> 1;
            setActualScale(1,1);
            setSize(actualWidth,actualHeight);
         }
      }
      
      override protected function onDispose() : void
      {
         this.icon = null;
         this.states = null;
         super.onDispose();
      }
   }
}
