package net.wg.gui.lobby.header.headerButtonBar
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class HeaderButtonActionContent extends Sprite
   {
       
      
      public var actionBg:DisplayObject = null;
      
      public var actionIcon:DisplayObject = null;
      
      public function HeaderButtonActionContent()
      {
         super();
         this.actionBg.visible = false;
         this.actionIcon.visible = false;
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         this.actionBg.visible = param1;
         this.actionIcon.visible = param1;
      }
      
      public function updateSize(param1:Rectangle) : void
      {
         this.actionBg.x = this.actionIcon.x = param1.x + (param1.width >> 1);
         this.actionBg.y = this.actionIcon.y = param1.y + param1.height;
      }
   }
}
