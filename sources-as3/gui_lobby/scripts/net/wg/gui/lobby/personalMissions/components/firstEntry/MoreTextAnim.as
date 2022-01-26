package net.wg.gui.lobby.personalMissions.components.firstEntry
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.TextFieldContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class MoreTextAnim extends Sprite implements IDisposable
   {
       
      
      public var more:TextFieldContainer = null;
      
      public function MoreTextAnim()
      {
         super();
      }
      
      public function dispose() : void
      {
         this.more.dispose();
         this.more = null;
      }
      
      public function setSize(param1:int, param2:int, param3:int) : void
      {
         this.more.x = param1 >> 1;
         this.more.y = param3;
      }
      
      public function setText(param1:String) : void
      {
         this.more.label = param1;
      }
   }
}
