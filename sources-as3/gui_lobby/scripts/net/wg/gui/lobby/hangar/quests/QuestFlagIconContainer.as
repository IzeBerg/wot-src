package net.wg.gui.lobby.hangar.quests
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class QuestFlagIconContainer extends Sprite implements IDisposable
   {
       
      
      public var icon:UILoaderAlt = null;
      
      private var _enabled:Boolean = true;
      
      public function QuestFlagIconContainer()
      {
         super();
         this.mouseEnabled = this.mouseChildren = false;
      }
      
      public final function dispose() : void
      {
         this.icon.dispose();
         this.icon = null;
      }
      
      public function setIcon(param1:String) : void
      {
         this.icon.source = param1;
      }
      
      private function updateState() : void
      {
         if(this._enabled)
         {
            this.icon.filters = [];
         }
         else
         {
            App.utils.commons.setSaturation(this.icon,0);
         }
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(this._enabled == param1)
         {
            return;
         }
         this._enabled = param1;
         this.updateState();
      }
   }
}
