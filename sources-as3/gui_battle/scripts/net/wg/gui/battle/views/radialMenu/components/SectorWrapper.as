package net.wg.gui.battle.views.radialMenu.components
{
   import flash.display.Sprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SectorWrapper extends Sprite implements IDisposable
   {
       
      
      public var content:Content = null;
      
      public var hitAreaSpr:Sprite = null;
      
      public function SectorWrapper()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.content.dispose();
         this.content = null;
         this.hitAreaSpr = null;
      }
   }
}
