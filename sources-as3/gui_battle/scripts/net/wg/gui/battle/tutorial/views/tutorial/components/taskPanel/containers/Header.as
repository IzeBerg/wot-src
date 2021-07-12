package net.wg.gui.battle.tutorial.views.tutorial.components.taskPanel.containers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class Header extends Sprite implements IDisposable
   {
       
      
      public var headerTF:TextField = null;
      
      public function Header()
      {
         super();
         TextFieldEx.setNoTranslate(this.headerTF,true);
      }
      
      public function dispose() : void
      {
         this.headerTF = null;
      }
      
      public function setHeaderText(param1:String) : void
      {
         this.headerTF.htmlText = param1;
      }
      
      public function getHeaderTextHeight() : int
      {
         return this.headerTF.textHeight;
      }
   }
}
