package net.wg.gui.lobby.eventBoards.components.headerComponents
{
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TextFieldNoSound extends Sprite implements IDisposable
   {
       
      
      public var textField:TextField = null;
      
      public function TextFieldNoSound()
      {
         super();
         var _loc1_:Sprite = new Sprite();
         var _loc2_:Graphics = _loc1_.graphics;
         _loc2_.beginFill(1,0);
         _loc2_.drawRect(0,0,1,1);
         _loc2_.endFill();
         addChild(_loc1_);
         this.hitArea = _loc1_;
      }
      
      public function dispose() : void
      {
         this.textField = null;
      }
   }
}
