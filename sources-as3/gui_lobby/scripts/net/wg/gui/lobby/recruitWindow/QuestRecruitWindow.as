package net.wg.gui.lobby.recruitWindow
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.Aliases;
   import net.wg.gui.components.advanced.RecruitParametersComponent;
   import net.wg.gui.components.assets.data.SeparatorConstants;
   import net.wg.gui.components.assets.interfaces.ISeparatorAsset;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.components.data.StoppableAnimationLoaderVO;
   import net.wg.gui.lobby.components.interfaces.IStoppableAnimationLoader;
   import net.wg.gui.lobby.personalMissions.data.QuestRecruitWindowVO;
   import net.wg.infrastructure.base.DefaultWindowGeometry;
   import net.wg.infrastructure.base.meta.IQuestRecruitWindowMeta;
   import net.wg.infrastructure.base.meta.impl.QuestRecruitWindowMeta;
   import net.wg.infrastructure.interfaces.IWindow;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.utils.Padding;
   
   public class QuestRecruitWindow extends QuestRecruitWindowMeta implements IQuestRecruitWindowMeta
   {
      
      private static const CANCEL_BTN_ADDITIONAL_HEIGHT:int = 4;
      
      private static const FIELD_NATION:String = "nation";
      
      private static const FIELD_VEHICLE_CLASS:String = "vehicleClass";
      
      private static const FIELD_VEHICLE:String = "vehicle";
      
      private static const FIELD_TANKMAN_ROLE:String = "tankmanRole";
       
      
      public var paramsComponent:RecruitParametersComponent;
      
      public var rankTF:TextField = null;
      
      public var rankLabelTF:TextField = null;
      
      public var nameTF:TextField = null;
      
      public var nameLabelTF:TextField = null;
      
      public var flags:MovieClip;
      
      public var applyButton:ISoundButtonEx;
      
      public var cancelButton:ISoundButtonEx;
      
      public var backAnimationLoader:IStoppableAnimationLoader = null;
      
      public var tankmanImage:Image = null;
      
      public var separator:ISeparatorAsset = null;
      
      public var bg:Image = null;
      
      public function QuestRecruitWindow()
      {
         super();
      }
      
      override public function setWindow(param1:IWindow) : void
      {
         super.setWindow(param1);
         var _loc2_:Padding = param1.formBgPadding;
         _loc2_.bottom += this.cancelButton.height + CANCEL_BTN_ADDITIONAL_HEIGHT;
         param1.formBgPadding = _loc2_;
         param1.useBottomBtns = true;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.rankTF.autoSize = this.nameTF.autoSize = TextFieldAutoSize.LEFT;
         this.rankLabelTF.autoSize = this.nameLabelTF.autoSize = TextFieldAutoSize.RIGHT;
         this.separator.setType(SeparatorConstants.MEDIUM_TYPE);
      }
      
      override protected function setInitData(param1:QuestRecruitWindowVO) : void
      {
         var _loc4_:String = null;
         var _loc5_:Boolean = false;
         window.title = param1.windowTitle;
         this.applyButton.label = param1.applyButtonLabel;
         this.cancelButton.label = param1.cancelButtonLabel;
         this.flags.gotoAndStop(param1.nation);
         this.rankTF.htmlText = param1.rank;
         this.nameTF.htmlText = param1.name;
         var _loc2_:String = param1.bgImage;
         if(StringUtils.isNotEmpty(_loc2_))
         {
            this.bg.source = _loc2_;
         }
         var _loc3_:StoppableAnimationLoaderVO = param1.backAnimationData;
         if(_loc3_)
         {
            this.backAnimationLoader.setData(_loc3_);
         }
         else
         {
            _loc4_ = param1.tankmanIcon;
            _loc5_ = StringUtils.isNotEmpty(_loc4_);
            this.tankmanImage.visible = _loc5_;
            if(_loc5_)
            {
               this.tankmanImage.source = _loc4_;
            }
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         geometry.positionStrategy = DefaultWindowGeometry.POSITION_ALWAYS;
         App.utils.scheduler.scheduleOnNextFrame(this.registerComponent);
         this.applyButton.addEventListener(ButtonEvent.CLICK,this.onApplyButtonClickHandler,false,0,true);
         this.cancelButton.addEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler,false,0,true);
         this.rankLabelTF.htmlText = MENU.TANKMANPERSONALCASE_RANK;
         this.nameLabelTF.htmlText = MENU.TANKMANPERSONALCASE_NAME;
      }
      
      override protected function onDispose() : void
      {
         App.utils.scheduler.cancelTask(this.registerComponent);
         this.applyButton.removeEventListener(ButtonEvent.CLICK,this.onApplyButtonClickHandler);
         this.applyButton.dispose();
         this.applyButton = null;
         this.cancelButton.removeEventListener(ButtonEvent.CLICK,this.onCancelButtonClickHandler);
         this.cancelButton.dispose();
         this.cancelButton = null;
         this.paramsComponent.removeEventListener(Event.CHANGE,this.onParamsComponentChangeHandler);
         this.paramsComponent = null;
         this.backAnimationLoader.dispose();
         this.backAnimationLoader = null;
         this.separator.dispose();
         this.separator = null;
         this.tankmanImage.dispose();
         this.tankmanImage = null;
         this.bg.dispose();
         this.bg = null;
         this.flags = null;
         this.rankTF = null;
         this.rankLabelTF = null;
         this.nameTF = null;
         this.nameLabelTF = null;
         super.onDispose();
      }
      
      private function registerComponent() : void
      {
         registerFlashComponentS(this.paramsComponent,Aliases.RECRUIT_PARAMS);
         this.paramsComponent.addEventListener(Event.CHANGE,this.onParamsComponentChangeHandler,false,0,true);
      }
      
      private function onCancelButtonClickHandler(param1:ButtonEvent) : void
      {
         onWindowCloseS();
      }
      
      private function onApplyButtonClickHandler(param1:ButtonEvent) : void
      {
         var _loc2_:Object = {};
         _loc2_[FIELD_NATION] = this.paramsComponent.getSelectedNation();
         _loc2_[FIELD_VEHICLE_CLASS] = this.paramsComponent.getSelectedVehicleClass();
         _loc2_[FIELD_VEHICLE] = this.paramsComponent.getSelectedVehicle();
         _loc2_[FIELD_TANKMAN_ROLE] = this.paramsComponent.getSelectedTankmanRole();
         onApplyS(_loc2_);
      }
      
      private function onParamsComponentChangeHandler(param1:Event = null) : void
      {
         this.applyButton.enabled = this.paramsComponent.vehicleClassDropdown.selectedIndex != 0 && this.paramsComponent.vehicleTypeDropdown.selectedIndex != 0 && (!!this.paramsComponent.roleDropdown.enabled ? Boolean(this.paramsComponent.roleDropdown.selectedIndex != 0) : Boolean(true));
      }
   }
}
