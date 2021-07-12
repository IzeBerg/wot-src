package net.wg.gui.components.battleRoyale
{
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ColumnHeader extends Sprite implements IDisposable
   {
      
      public static const DISABLED:int = 0;
      
      public static const ENABLED:int = 1;
      
      public static const SELECTED:int = 2;
      
      private static const DISABLED_ICON_ALPHA:Number = 0.2;
      
      private static const DISABLED_TEXT_ALPHA:Number = 0.6;
      
      private static const ENABLED_ALPHA:Number = 1;
      
      private static const SELECTED_ALPHA:Number = 0.8;
      
      private static const HEADER_SHADOW:DropShadowFilter = new DropShadowFilter(0,0,16756246,1,20,20,1,2);
       
      
      public var icon:Image = null;
      
      public var label:TextField = null;
      
      private var _status:int = -1;
      
      public function ColumnHeader()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         this.label = null;
      }
      
      public function setData(param1:String, param2:String) : void
      {
         this.icon.source = param1;
         this.label.text = param2;
      }
      
      public function set status(param1:int) : void
      {
         if(this._status != param1)
         {
            this._status = param1;
            this.updateEnabled();
         }
      }
      
      protected function updateEnabled() : void
      {
         this.filters = null;
         switch(this._status)
         {
            case SELECTED:
               this.icon.alpha = this.label.alpha = SELECTED_ALPHA;
               break;
            case ENABLED:
               this.icon.alpha = this.label.alpha = ENABLED_ALPHA;
               this.filters = [HEADER_SHADOW];
               break;
            default:
               this.icon.alpha = DISABLED_ICON_ALPHA;
               this.label.alpha = DISABLED_TEXT_ALPHA;
         }
      }
   }
}
