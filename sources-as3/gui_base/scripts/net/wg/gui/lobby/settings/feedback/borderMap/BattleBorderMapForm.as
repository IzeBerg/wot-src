package net.wg.gui.lobby.settings.feedback.borderMap
{
   import flash.text.TextField;
   import flash.text.TextFormatAlign;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.lobby.settings.components.RadioButtonBar;
   import net.wg.gui.lobby.settings.config.SettingsConfigHelper;
   import net.wg.gui.lobby.settings.feedback.FeedbackBaseForm;
   import net.wg.infrastructure.events.ColorSchemeEvent;
   import net.wg.infrastructure.managers.IColorSchemeManager;
   import net.wg.infrastructure.managers.counter.CounterProps;
   import net.wg.utils.ICounterProps;
   import scaleform.clik.motion.Tween;
   
   public class BattleBorderMapForm extends FeedbackBaseForm
   {
      
      private static const TYPE_PREFIX:String = "type_";
      
      private static const BORDER_MAP_INFO_INDEX:int = 2;
      
      private static const BORDER_MAP_TYPE_HIDE_INDEX:int = 2;
      
      private static const BLIND_OFFSET:int = 3;
      
      private static const ANIMATION_DURATION:int = 200;
      
      private static const SHOW_SLOTS_ALPHA:Number = 1;
      
      private static const HIDE_SLOTS_ALPHA:Number = 0;
      
      private static const COUNTER_BUTTON_BAR_OFFSET_X:Number = -7;
       
      
      public var borderMapTypeLabel:TextField = null;
      
      public var borderMapModeLabel:TextField = null;
      
      public var battleBorderMapTypeButtonBar:RadioButtonBar = null;
      
      public var battleBorderMapModeButtonBar:RadioButtonBar = null;
      
      public var borderContainer:BattleBorderMapBorderContainer = null;
      
      private var _colorMgr:IColorSchemeManager;
      
      private var _tweenInfoHide:Tween = null;
      
      private var _tweenInfoShow:Tween = null;
      
      public function BattleBorderMapForm()
      {
         this._colorMgr = App.colorSchemeMgr;
         super();
      }
      
      private static function pauseCurrentAnim(param1:Tween, param2:Tween) : void
      {
         if(param1)
         {
            param1.paused = true;
         }
         if(param2)
         {
            param2.paused = true;
            param2.dispose();
         }
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         this.setMapModeEnabled();
      }
      
      override protected function getCounterProps(param1:String) : ICounterProps
      {
         if(param1 == SettingsConfigHelper.TYPE_BUTTON_BAR)
         {
            return new CounterProps(COUNTER_BUTTON_BAR_OFFSET_X,CounterProps.DEFAULT_OFFSET_Y,TextFormatAlign.LEFT,false,Linkages.COUNTER_LINE_UI);
         }
         return super.getCounterProps(param1);
      }
      
      override protected function setupButtonBar(param1:RadioButtonBar, param2:Array, param3:int, param4:Boolean) : void
      {
         super.setupButtonBar(param1,param2,param3,param4);
         this.battleBorderMapModeButtonBar.setInfoButton(TOOLTIPS.BATTLEBORDERMAPMODEBUTTONBAR_INFO,BORDER_MAP_INFO_INDEX);
         this.battleBorderMapTypeButtonBar.setWarningButton(TOOLTIPS.BATTLEBORDERMAPTYPEBUTTONBAR_INFO,BORDER_MAP_TYPE_HIDE_INDEX);
         if(param1 == this.battleBorderMapTypeButtonBar)
         {
            this.updateBorder(param1.selectedIndex);
         }
      }
      
      override protected function onButtonBarIndexChange(param1:RadioButtonBar) : void
      {
         super.onButtonBarIndexChange(param1);
         if(param1 == this.battleBorderMapTypeButtonBar)
         {
            this.setMapModeEnabled();
            this.setStateBorderContainer(param1);
         }
      }
      
      override protected function onDispose() : void
      {
         this._colorMgr.removeEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorMgrSchemasUpdatedHandler);
         if(this._tweenInfoHide)
         {
            this._tweenInfoHide.paused = true;
            this._tweenInfoHide.dispose();
            this._tweenInfoHide = null;
         }
         if(this._tweenInfoShow)
         {
            this._tweenInfoShow.paused = true;
            this._tweenInfoShow.dispose();
            this._tweenInfoShow = null;
         }
         this.borderMapModeLabel = null;
         this.borderMapTypeLabel = null;
         this._colorMgr = null;
         this.battleBorderMapTypeButtonBar.dispose();
         this.battleBorderMapTypeButtonBar = null;
         this.battleBorderMapModeButtonBar.dispose();
         this.battleBorderMapModeButtonBar = null;
         this.borderContainer.dispose();
         this.borderContainer = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.borderMapTypeLabel.text = SETTINGS.FEEDBACK_TAB_BORDERMAP_TYPEBORDER_LABEL;
         this.borderMapModeLabel.text = SETTINGS.FEEDBACK_TAB_BORDERMAP_SHOWMODE_LABEL;
         this.borderContainer.setText(SETTINGS.FEEDBACK_TAB_BORDERMAP_HIDEBORDERWARNING);
         this._colorMgr.addEventListener(ColorSchemeEvent.SCHEMAS_UPDATED,this.onColorMgrSchemasUpdatedHandler);
      }
      
      private function setMapModeEnabled() : void
      {
         var _loc1_:Boolean = this.battleBorderMapTypeButtonBar.dataProvider[this.battleBorderMapTypeButtonBar.selectedIndex].data != BORDER_MAP_TYPE_HIDE_INDEX;
         setElementEnabled(this.battleBorderMapModeButtonBar,_loc1_);
      }
      
      private function setStateBorderContainer(param1:RadioButtonBar) : void
      {
         var buttonBar:RadioButtonBar = param1;
         if(buttonBar == this.battleBorderMapModeButtonBar)
         {
            return;
         }
         pauseCurrentAnim(this._tweenInfoShow,this._tweenInfoHide);
         this._tweenInfoHide = new Tween(ANIMATION_DURATION,this.borderContainer,{"alpha":HIDE_SLOTS_ALPHA},{"onComplete":function():void
         {
            updateBorder(buttonBar.selectedIndex);
            pauseCurrentAnim(_tweenInfoHide,_tweenInfoShow);
            if(borderContainer.alpha != SHOW_SLOTS_ALPHA)
            {
               _tweenInfoShow = new Tween(ANIMATION_DURATION,borderContainer,{"alpha":SHOW_SLOTS_ALPHA});
            }
         }});
      }
      
      private function updateBorder(param1:int) : void
      {
         var _loc2_:Boolean = param1 == BORDER_MAP_TYPE_HIDE_INDEX;
         var _loc3_:int = this._colorMgr.getIsColorBlindS() && !_loc2_ ? int(param1 + BLIND_OFFSET) : int(param1);
         this.borderContainer.gotoAndStop(TYPE_PREFIX + _loc3_);
         this.borderContainer.setTextVisible(_loc2_);
      }
      
      override public function get formId() : String
      {
         return Linkages.FEEDBACK_BATTLE_BORDER_MAP;
      }
      
      private function onColorMgrSchemasUpdatedHandler(param1:ColorSchemeEvent) : void
      {
         this.setStateBorderContainer(this.battleBorderMapTypeButtonBar);
      }
   }
}
