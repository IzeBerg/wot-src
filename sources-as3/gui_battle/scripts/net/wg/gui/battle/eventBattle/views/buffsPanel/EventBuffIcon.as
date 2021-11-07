package net.wg.gui.battle.eventBattle.views.buffsPanel
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleAtlasSprite;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class EventBuffIcon extends MovieClip implements IDisposable
   {
       
      
      public var icon:BattleAtlasSprite = null;
      
      public function EventBuffIcon()
      {
         super();
      }
      
      public function set iconPath(param1:String) : void
      {
         this.icon.imageName = param1;
      }
      
      public final function dispose() : void
      {
         this.icon = null;
      }
   }
}
