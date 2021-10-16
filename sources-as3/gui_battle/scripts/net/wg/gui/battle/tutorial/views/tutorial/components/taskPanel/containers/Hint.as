package net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class Hint extends Sprite implements IDisposable
   {
      
      private static const OFFSET_PICTURE_Y:int = 15;
       
      
      public var hintTF:TextField = null;
      
      public var picture:UILoaderAlt = null;
      
      public function Hint()
      {
         super();
         TextFieldEx.setNoTranslate(this.hintTF,true);
      }
      
      public function setHintText(param1:String) : void
      {
         this.hintTF.htmlText = param1;
      }
      
      public function getHintTextHeight() : int
      {
         return this.hintTF.textHeight;
      }
      
      public function getHintTextY() : int
      {
         return this.hintTF.y;
      }
      
      public function unloadPicture() : void
      {
         this.picture.unload();
      }
      
      public function setPictureVisible(param1:Boolean) : void
      {
         this.picture.visible = param1;
      }
      
      public function autoPositionPicture() : void
      {
         this.picture.y = this.getHintTextY() + this.getHintTextHeight() + OFFSET_PICTURE_Y;
      }
      
      public function setPictureSource(param1:String) : void
      {
         this.picture.source = param1;
      }
      
      public function setPictureSourceAlt(param1:String) : void
      {
         this.picture.sourceAlt = param1;
      }
      
      public function getPictureSource() : String
      {
         return this.picture.source;
      }
      
      public function getPictureSourceAlt() : String
      {
         return this.picture.sourceAlt;
      }
      
      public function dispose() : void
      {
         this.picture.dispose();
         this.picture = null;
         this.hintTF = null;
      }
   }
}
