package net.wg.gui.lobby.personalMissions.components.firstEntry
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class InfoItemRendererBg extends Sprite implements IDisposable
   {
       
      
      public var sprite:Sprite = null;
      
      public function InfoItemRendererBg()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.sprite = null;
      }
      
      public function setSize(param1:int, param2:int) : void
      {
         this.sprite.width = param1;
         this.sprite.height = param2;
      }
   }
}
