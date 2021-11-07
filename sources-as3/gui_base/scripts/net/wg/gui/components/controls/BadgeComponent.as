package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.gui.components.advanced.BadgeSizes;
   import net.wg.gui.components.advanced.DigitsComponent;
   import net.wg.gui.components.controls.VO.BadgeVisualVO;
   import net.wg.infrastructure.interfaces.IImage;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BadgeComponent extends Sprite implements IDisposable
   {
      
      private static const CONTENT_VERTICAL_OFFSETS:Dictionary = new Dictionary();
      
      private static const CONTENT_NAME:String = "content";
      
      {
         CONTENT_VERTICAL_OFFSETS[BadgeSizes.X24] = 0.3;
         CONTENT_VERTICAL_OFFSETS[BadgeSizes.X48] = 0.35;
         CONTENT_VERTICAL_OFFSETS[BadgeSizes.X80] = 0.4;
         CONTENT_VERTICAL_OFFSETS[BadgeSizes.X220] = 0.42;
      }
      
      public var icon:IImage = null;
      
      private var _content:DigitsComponent = null;
      
      private var _size:String = "";
      
      public function BadgeComponent()
      {
         super();
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
      }
      
      public final function dispose() : void
      {
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
         if(this._content != null)
         {
            this._content.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
            removeChild(this._content);
            this._content.dispose();
            this._content = null;
         }
      }
      
      public function setData(param1:BadgeVisualVO) : void
      {
         visible = param1 != null;
         if(param1 == null)
         {
            DebugUtils.LOG_WARNING("Empty badge data");
            return;
         }
         if(param1.isDynamic)
         {
            if(this._content == null)
            {
               this.createContent(param1.isAtlasSource);
            }
            this._content.visible = true;
         }
         else if(this._content != null)
         {
            this._content.visible = false;
         }
         if(this._content != null)
         {
            this._content.setData(param1.content,param1.sizeContent);
         }
         this._size = param1.sizeContent;
         if(param1.isAtlasSource)
         {
            App.atlasMgr.drawGraphics(ATLAS_CONSTANTS.BATTLE_ATLAS,param1.icon,graphics,"",true);
            this.updateSize();
         }
         else
         {
            this.icon.source = param1.icon;
         }
      }
      
      private function createContent(param1:Boolean) : void
      {
         this._content = new DigitsComponent(param1);
         this._content.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         this._content.name = CONTENT_NAME;
         addChild(this._content);
      }
      
      private function updateSize() : void
      {
         if(this._content != null && this._content.visible)
         {
            this._content.x = Math.floor((width - this._content.width) * 0.5);
            this._content.y = Math.round((height - this._content.height) * CONTENT_VERTICAL_OFFSETS[this._size]);
         }
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         this.updateSize();
         dispatchEvent(new Event(Event.CHANGE));
      }
   }
}
