package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.components.advanced.BadgeSizes;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BadgeComponent extends Sprite implements IDisposable
   {
      
      private static const CONTENT_VERTICAL_OFFSETS:Dictionary = new Dictionary();
      
      {
         CONTENT_VERTICAL_OFFSETS[BadgeSizes.X24] = 0.3;
         CONTENT_VERTICAL_OFFSETS[BadgeSizes.X48] = 0.35;
         CONTENT_VERTICAL_OFFSETS[BadgeSizes.X80] = 0.4;
         CONTENT_VERTICAL_OFFSETS[BadgeSizes.X220] = 0.42;
      }
      
      public var icon:IImage = null;
      
      private var _disposed:Boolean = false;
      
      public function BadgeComponent()
      {
         super();
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
      }
      
      public function setData(param1:BadgeVisualVO) : void
      {
         visible = param1 != null;
         if(param1 == null)
         {
            DebugUtils.LOG_WARNING("Empty badge data");
            return;
         }
         if(param1.isAtlasSource)
         {
            App.atlasMgr.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1.icon,graphics,"",true);
         }
         else
         {
            this.icon.source = param1.icon;
         }
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         dispatchEvent(new Event(Event.CHANGE));
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
