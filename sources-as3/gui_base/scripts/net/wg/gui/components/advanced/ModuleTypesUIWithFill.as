package net.wg.gui.components.advanced
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class ModuleTypesUIWithFill extends UIComponentEx
   {
      
      protected static const MODULE_TYPE_NONE:String = "none";
      
      private static const INV_MODULE_ICON_POS:String = "invModuleIconPos";
      
      private static const INV_EXTRA_ICON_POS:String = "invExtraIconPos";
      
      private static const ERROR_NO_MODULE_ICON:String = "[ModuleTypesUIWithFill] moduleIcon ";
      
      private static const EXTRA_ICON_PADDING_RIGHT:int = 2;
      
      private static const EXTRA_ICON_PADDING_BOTTOM:int = 2;
      
      private static const EXTRA_ICON_NAME:String = "extraIconImage";
       
      
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
         if(this.moduleIcon != null)
         {
            this.moduleIcon.addEventListener(Event.CHANGE,this.onModuleIconChangeHandler);
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
            this._extraIcon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
            this._extraIcon.dispose();
            this._extraIcon = null;
         }
         if(this.moduleIcon != null)
         {
            this.moduleIcon.removeEventListener(Event.CHANGE,this.onModuleIconChangeHandler);
            this.moduleIcon.dispose();
            this.moduleIcon = null;
         }
         this.bg = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.moduleIcon && isInvalid(INV_MODULE_ICON_POS))
         {
            this.moduleIcon.x = (this.bg.width - this.moduleIcon.width) * scaleX >> 1;
            this.moduleIcon.y = (this.bg.height - this.moduleIcon.height) * scaleY >> 1;
         }
         if(this._extraIcon && isInvalid(INV_EXTRA_ICON_POS))
         {
            this._extraIcon.x = this.bg.width - this._extraIcon.width - EXTRA_ICON_PADDING_RIGHT | 0;
            this._extraIcon.y = this.bg.height - this._extraIcon.height - EXTRA_ICON_PADDING_BOTTOM | 0;
         }
      }
      
      public function hideExtraIcon() : void
      {
         if(!initialized)
         {
            this._isExtraIconShowedBeforeInit = false;
         }
         if(this._extraIcon)
         {
            this._extraIcon.visible = false;
         }
      }
      
      public function setExtraIconBySource(param1:String) : void
      {
         if(!this._extraIcon)
         {
            this._extraIcon = new Image();
            this._extraIcon.name = EXTRA_ICON_NAME;
            this._extraIcon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
            this._extraIcon.visible = this._isExtraIconShowedBeforeInit;
            addChild(this._extraIcon);
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
         if(this._extraIcon)
         {
            this._extraIcon.visible = true;
         }
      }
      
      public function set extraIconAlpha(param1:Number) : void
      {
         if(this._extraIcon)
         {
            this._extraIcon.alpha = param1;
         }
      }
      
      private function onModuleIconChangeHandler(param1:Event) : void
      {
         invalidate(INV_MODULE_ICON_POS);
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         invalidate(INV_EXTRA_ICON_POS);
      }
   }
}
