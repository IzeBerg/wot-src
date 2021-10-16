package net.wg.gui.components.carousels.controls.levelInfo
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class LevelLabelContainer extends MovieClip implements IDisposable
   {
       
      
      public var levelTf:TextFieldContainer = null;
      
      public function LevelLabelContainer()
      {
         super();
      }
      
      public function get textField() : TextField
      {
         return this.levelTf.textField;
      }
      
      public function set label(param1:String) : void
      {
         this.levelTf.label = param1;
      }
      
      public function updateState(param1:String) : void
      {
         this.gotoAndStop(param1);
      }
      
      public function dispose() : void
      {
         this.levelTf.dispose();
         this.levelTf = null;
      }
   }
}
