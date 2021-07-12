package net.wg.gui.components.advanced
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class ModuleTypesUIWithFill extends UIComponentEx
   {
      
      private static const INV_MODULE_ICON_POS:String = "invModuleIconPos";
      
      protected static const MODULE_TYPE_NONE:String = "none";
      
      private static const ERROR_NO_MODULE_ICON:String = "[ModuleTypesUIWithFill] moduleIcon ";
       
      
      public var extraIconBitmapFill:BitmapFill = null;
      
      public var moduleIcon:Image = null;
      
      public var bg:Sprite = null;
      
      private var _extraIcon:Image = null;
      
      private var _isExtraIconShowedBeforeInit:Boolean;
      
      public function ModuleTypesUIWithFill()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(!this._isExtraIconShowedBeforeInit)
         {
            this.hideExtraIcon();
         }
         if(this.moduleIcon != null)
         {
            this.moduleIcon.addEventListener(Event.CHANGE,this.onModuleIconHandler);
         }
         else
         {
            DebugUtils.LOG_ERROR(ERROR_NO_MODULE_ICON + Errors.WASNT_FOUND);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._extraIcon != null)
         {
            this._extraIcon.removeEventListener(Event.CHANGE,this.onIconLoadedHandler);
            this._extraIcon.dispose();
            this._extraIcon = null;
         }
         this.extraIconBitmapFill.dispose();
         this.extraIconBitmapFill = null;
         if(this.moduleIcon != null)
         {
            this.moduleIcon.removeEventListener(Event.CHANGE,this.onModuleIconHandler);
            this.moduleIcon.dispose();
            this.moduleIcon = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(INV_MODULE_ICON_POS && this.moduleIcon)
         {
            this.moduleIcon.x = (this.bg.width - this.moduleIcon.width) * scaleX >> 1;
            this.moduleIcon.y = (this.bg.height - this.moduleIcon.height) * scaleY >> 1;
         }
      }
      
      public function hideExtraIcon() : void
      {
         if(!initialized)
         {
            this._isExtraIconShowedBeforeInit = false;
         }
         this.extraIconBitmapFill.visible = false;
      }
      
      public function setExtraIconByLinkage(param1:String) : void
      {
         this.extraIconBitmapFill.source = param1;
         this.extraIconBitmapFill.validateNow();
      }
      
      public function setExtraIconBySource(param1:String) : void
      {
         if(this._extraIcon == null)
         {
            this._extraIcon = new Image();
            this._extraIcon.addEventListener(Event.CHANGE,this.onIconLoadedHandler);
         }
         this._extraIcon.source = param1;
      }
      
      public function setModuleTypeIcon(param1:String) : void
      {
         if(this.moduleIcon == null)
         {
            DebugUtils.LOG_ERROR(ERROR_NO_MODULE_ICON + Errors.WASNT_FOUND);
            return;
         }
         if(param1 != MODULE_TYPE_NONE)
         {
            this.moduleIcon.source = RES_ICONS.getModuleTypesIcon(param1);
         }
         else
         {
            this.moduleIcon.source = null;
         }
      }
      
      public function showExtraIcon() : void
      {
         if(!initialized)
         {
            this._isExtraIconShowedBeforeInit = true;
         }
         this.extraIconBitmapFill.visible = true;
      }
      
      public function set extraIconX(param1:Number) : void
      {
         this.extraIconBitmapFill.x = param1;
      }
      
      public function set extraIconY(param1:Number) : void
      {
         this.extraIconBitmapFill.y = param1;
      }
      
      public function get extraIconAlpha() : Number
      {
         return this.extraIconBitmapFill.alpha;
      }
      
      public function set extraIconAlpha(param1:Number) : void
      {
         this.extraIconBitmapFill.alpha = param1;
      }
      
      private function onModuleIconHandler(param1:Event) : void
      {
         invalidate(INV_MODULE_ICON_POS);
      }
      
      private function onIconLoadedHandler(param1:Event) : void
      {
         this.extraIconBitmapFill.setBitmap(this._extraIcon.bitmapData);
         this.extraIconBitmapFill.validateNow();
      }
   }
}
