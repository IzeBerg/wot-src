package net.wg.gui.lobby.personalMissions.components.awardsView
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.personalMissions.data.PersonalMissionsItemSlotVO;
   import net.wg.gui.lobby.personalMissions.events.PersonalMissionsItemSlotEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.ISoundable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class PersonalMissionsItemSlot extends UIComponentEx implements ISoundable
   {
      
      private static const NOT_COLLECTED_ALPHA:Number = 0.5;
      
      private static const VEHICLE_TYPE_ALPHA:Number = 0.5;
      
      private static const ALLIANCE_ICON_ALPHA:Number = 0.7;
      
      private static const BASE_ROLL_OVER_ALPHA:Number = 1;
      
      private static const BASE_ALPHA:int = 1;
       
      
      public var unlockBtn:ISoundButtonEx = null;
      
      public var markMc:MovieClip = null;
      
      public var tankTypes:MovieClip = null;
      
      public var iconLoader:UILoaderAlt = null;
      
      public var bgMc:MovieClip = null;
      
      public var bgDoneMc:MovieClip = null;
      
      public var hitMC:MovieClip = null;
      
      public var allianceIcon:Image = null;
      
      private var _slotData:PersonalMissionsItemSlotVO = null;
      
      private var _toolTipMgr:ITooltipMgr;
      
      public function PersonalMissionsItemSlot()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.unlockBtn.removeEventListener(MouseEvent.CLICK,this.onUnlockBtnClickHandler);
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.iconLoader.dispose();
         this.iconLoader = null;
         this.unlockBtn.dispose();
         this.unlockBtn = null;
         this.bgMc = null;
         this.bgDoneMc = null;
         this.markMc = null;
         this.tankTypes = null;
         this._slotData = null;
         this._toolTipMgr = null;
         this.hitMC = null;
         this.allianceIcon.dispose();
         this.allianceIcon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         hitArea = this.hitMC;
         this.markMc.mouseEnabled = this.tankTypes.mouseEnabled = this.allianceIcon.mouseEnabled = this.iconLoader.mouseEnabled = this.bgMc.mouseEnabled = false;
         this.markMc.mouseChildren = this.tankTypes.mouseChildren = this.allianceIcon.mouseChildren = this.iconLoader.mouseChildren = this.bgMc.mouseChildren = false;
         this.bgDoneMc.mouseEnabled = false;
         buttonMode = useHandCursor = true;
         this.tankTypes.alpha = VEHICLE_TYPE_ALPHA;
         this.allianceIcon.alpha = ALLIANCE_ICON_ALPHA;
         this.unlockBtn.useHtmlText = true;
         this.unlockBtn.addEventListener(MouseEvent.CLICK,this.onUnlockBtnClickHandler);
         SoundButton(this.unlockBtn).soundEnabled = false;
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.tankTypes.visible = false;
         this.allianceIcon.visible = false;
         if(App.soundMgr != null)
         {
            App.soundMgr.addSoundsHdlrs(this);
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._slotData)
            {
               _loc1_ = this._slotData.iconSource;
               _loc2_ = StringUtils.isNotEmpty(_loc1_);
               if(_loc2_)
               {
                  this.iconLoader.source = _loc1_;
               }
               this.iconLoader.visible = _loc2_;
               _loc3_ = this._slotData.canUnlock;
               this.unlockBtn.visible = _loc3_;
               if(_loc3_)
               {
                  this.unlockBtn.label = this._slotData.unlockBtnLabel;
               }
               _loc4_ = this._slotData.isCollected;
               this.markMc.visible = _loc4_;
               this.iconLoader.alpha = this.tankTypes.alpha = this.allianceIcon.alpha = !!_loc4_ ? Number(BASE_ALPHA) : Number(NOT_COLLECTED_ALPHA);
               this.bgDoneMc.visible = _loc4_;
               this.bgMc.visible = !_loc4_;
               this.allianceIcon.visible = StringUtils.isNotEmpty(this._slotData.allianceIcon);
               if(this.allianceIcon.visible)
               {
                  this.allianceIcon.source = this._slotData.allianceIcon;
               }
               this.tankTypes.visible = !this.allianceIcon.visible && StringUtils.isNotEmpty(this._slotData.tokenType);
               if(this.tankTypes.visible)
               {
                  this.tankTypes.gotoAndStop(this._slotData.tokenType);
               }
            }
            else
            {
               this.clear();
            }
         }
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return enabled;
      }
      
      public function getSoundId() : String
      {
         return Values.EMPTY_STR;
      }
      
      public function getSoundType() : String
      {
         return SoundTypes.NORMAL_BTN;
      }
      
      public function setData(param1:PersonalMissionsItemSlotVO) : void
      {
         this._slotData = param1;
         invalidateData();
      }
      
      private function clear() : void
      {
         this.unlockBtn.visible = false;
         this.markMc.visible = false;
         this.iconLoader.visible = false;
         this.bgDoneMc.visible = false;
         this.bgMc.visible = true;
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
         if(this._slotData && param1.target != this.unlockBtn)
         {
            this.iconLoader.alpha = this.tankTypes.alpha = this.allianceIcon.alpha = !!this._slotData.isCollected ? Number(BASE_ALPHA) : Number(NOT_COLLECTED_ALPHA);
         }
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ToolTipVO = null;
         if(this._slotData)
         {
            if(param1.target != this.unlockBtn)
            {
               this.iconLoader.alpha = this.tankTypes.alpha = this.allianceIcon.alpha = BASE_ROLL_OVER_ALPHA;
            }
            _loc2_ = this._slotData.tooltipData;
            if(_loc2_.isSpecial)
            {
               this._toolTipMgr.showSpecial.apply(this._toolTipMgr,[_loc2_.specialAlias,null].concat(_loc2_.specialArgs));
            }
         }
      }
      
      private function onUnlockBtnClickHandler(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(this._slotData && App.utils.commons.isLeftButton(param1))
         {
            dispatchEvent(new PersonalMissionsItemSlotEvent(PersonalMissionsItemSlotEvent.UNLOCK,this._slotData.tokenType,true));
         }
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(this._slotData && App.utils.commons.isLeftButton(param1))
         {
            dispatchEvent(new PersonalMissionsItemSlotEvent(PersonalMissionsItemSlotEvent.CLICK,this._slotData.tokenType,true));
         }
      }
   }
}
