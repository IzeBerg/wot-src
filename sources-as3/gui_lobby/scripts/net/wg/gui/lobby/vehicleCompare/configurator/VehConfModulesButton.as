package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.gui.lobby.vehicleCompare.events.VehConfEvent;
   import net.wg.gui.utils.ExcludeTweenManager;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class VehConfModulesButton extends SoundButtonEx
   {
      
      private static const BG_ROLL_OVER_ALPHA:Number = 0.07;
      
      private static const BG_ROLL_OUT_ALPHA:Number = 0.03;
      
      private static const TWEEN_DURATION:Number = 150;
      
      private static const BG_HEIGHT_BIG:int = 90;
      
      private static const BG_HEIGHT_SMALL:int = 68;
      
      private static const SEPARATORS_HEIGHT:int = 70;
       
      
      public var separators:MovieClip;
      
      public var bg:MovieClip;
      
      public var vehicleGun:VehConfModuleSlot;
      
      public var vehicleTurret:VehConfModuleSlot;
      
      public var vehicleEngine:VehConfModuleSlot;
      
      public var vehicleChassis:VehConfModuleSlot;
      
      public var vehicleWheeledChassis:VehConfModuleSlot;
      
      public var vehicleRadio:VehConfModuleSlot;
      
      private var _tweenManager:ExcludeTweenManager;
      
      private var _modules:Vector.<UIComponentEx>;
      
      private var _dataVOs:Vector.<DeviceSlotVO>;
      
      private var _isSmall:Boolean = false;
      
      public function VehConfModulesButton()
      {
         this._tweenManager = new ExcludeTweenManager();
         super();
         this._modules = new <UIComponentEx>[this.vehicleGun,this.vehicleTurret,this.vehicleEngine,this.vehicleChassis,this.vehicleWheeledChassis,this.vehicleRadio];
      }
      
      override protected function changeFocus() : void
      {
         this.applyBgAlpha(Boolean(focused) ? Number(BG_ROLL_OVER_ALPHA) : Number(BG_ROLL_OUT_ALPHA));
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:UIComponentEx = null;
         var _loc2_:IDisposable = null;
         removeEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler);
         removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         for each(_loc1_ in this._modules)
         {
            _loc1_.removeEventListener(MouseEvent.ROLL_OVER,this.onModuleRollOverHandler);
            _loc1_.removeEventListener(MouseEvent.ROLL_OUT,this.onModuleRollOutHandler);
            _loc1_.dispose();
         }
         this._modules.splice(0,this._modules.length);
         this._modules = null;
         for each(_loc2_ in this._dataVOs)
         {
            _loc2_.dispose();
         }
         this._dataVOs.splice(0,this._dataVOs.length);
         this._dataVOs = null;
         this.separators = null;
         this.bg = null;
         this.vehicleGun = null;
         this.vehicleTurret = null;
         this.vehicleEngine = null;
         this.vehicleChassis = null;
         this.vehicleWheeledChassis = null;
         this.vehicleRadio = null;
         this._tweenManager.dispose();
         this._tweenManager = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         var _loc1_:UIComponentEx = null;
         super.configUI();
         this.vehicleGun.iconSource = RES_ICONS.MAPS_ICONS_HANGARTUTORIAL_MODULES_GUN;
         this.vehicleTurret.iconSource = RES_ICONS.MAPS_ICONS_HANGARTUTORIAL_MODULES_TOWER;
         this.vehicleEngine.iconSource = RES_ICONS.MAPS_ICONS_HANGARTUTORIAL_MODULES_ENGINE;
         this.vehicleChassis.iconSource = RES_ICONS.MAPS_ICONS_HANGARTUTORIAL_MODULES_CHASSIS;
         this.vehicleWheeledChassis.iconSource = RES_ICONS.MAPS_ICONS_HANGARTUTORIAL_MODULES_WHEEL;
         this.vehicleRadio.iconSource = RES_ICONS.MAPS_ICONS_HANGARTUTORIAL_MODULES_RADIO;
         this.bg.buttonMode = enabled;
         this.bg.useHandCursor = enabled;
         this.bg.alpha = BG_ROLL_OUT_ALPHA;
         mouseChildren = true;
         mouseEnabled = false;
         for each(_loc1_ in this._modules)
         {
            _loc1_.addEventListener(MouseEvent.ROLL_OVER,this.onModuleRollOverHandler);
            _loc1_.addEventListener(MouseEvent.ROLL_OUT,this.onModuleRollOutHandler);
            _loc1_.buttonMode = enabled;
            _loc1_.useHandCursor = enabled;
            _loc1_.visible = false;
         }
         addEventListener(MouseEvent.ROLL_OVER,this.onButtonRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onButtonRollOutHandler);
         addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:VehConfModuleSlot = null;
         var _loc2_:DeviceSlotVO = null;
         var _loc3_:UIComponentEx = null;
         if(this._dataVOs && isInvalid(InvalidationType.DATA))
         {
            for each(_loc2_ in this._dataVOs)
            {
               _loc1_ = VehConfModuleSlot(this[_loc2_.slotType]);
               if(_loc1_)
               {
                  _loc1_.setData(_loc2_);
                  _loc1_.visible = true;
               }
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.bg.height = !!this._isSmall ? Number(BG_HEIGHT_SMALL) : Number(BG_HEIGHT_BIG);
            this.separators.y = (this.bg.height - SEPARATORS_HEIGHT >> 1) + this.bg.y;
            for each(_loc3_ in this._modules)
            {
               _loc3_.y = this.bg.height - _loc3_.height >> 1;
            }
         }
         super.draw();
      }
      
      public function setData(param1:Vector.<DeviceSlotVO>) : void
      {
         this._dataVOs = param1;
         invalidateData();
      }
      
      public function setIsSmall(param1:Boolean) : void
      {
         if(this._isSmall != param1)
         {
            this._isSmall = param1;
            invalidateSize();
            validateNow();
         }
      }
      
      private function applyBgAlpha(param1:Number) : void
      {
         this._tweenManager.unregisterAll();
         this._tweenManager.registerAndLaunch(TWEEN_DURATION,this.bg,{"alpha":param1},{});
      }
      
      override public function get height() : Number
      {
         if(this.bg)
         {
            return this.bg.y + this.bg.height;
         }
         return super.height;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         var _loc2_:UIComponentEx = null;
         super.enabled = param1;
         this.bg.buttonMode = param1;
         this.bg.useHandCursor = param1;
         for each(_loc2_ in this._modules)
         {
            _loc2_.buttonMode = param1;
            _loc2_.useHandCursor = enabled;
         }
      }
      
      private function onModuleRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onModuleRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:VehConfModuleSlot = VehConfModuleSlot(param1.target);
         _loc2_.showTooltip();
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new VehConfEvent(VehConfEvent.MODULES_CLICK,true));
      }
      
      private function onButtonRollOutHandler(param1:MouseEvent) : void
      {
         if(enabled)
         {
            this.applyBgAlpha(BG_ROLL_OUT_ALPHA);
         }
      }
      
      private function onButtonRollOverHandler(param1:MouseEvent) : void
      {
         if(enabled)
         {
            this.applyBgAlpha(BG_ROLL_OVER_ALPHA);
         }
      }
   }
}
