package net.wg.gui.battle.views.questProgress.components
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.battle.views.questProgress.data.QPTrackingDataItemVO;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.questProgress.QuestProgressAtlasSprite;
   import scaleform.clik.events.InputEvent;
   
   public class QuestTrackingButton extends SoundButtonEx
   {
      
      private static const INACTIVE_ALPHA:Number = 0.5;
      
      private static const SELECTED_STATE_INV:String = "onSelectedStateInvalidate";
       
      
      public var onPause:QuestTrackingOnPause = null;
      
      public var border:MovieClip = null;
      
      public var trackingImg:Sprite = null;
      
      public var operationName:TextField = null;
      
      public var missionName:TextField = null;
      
      public var vehicle:QuestProgressAtlasSprite = null;
      
      public var disabled:MovieClip = null;
      
      public var bg:MovieClip = null;
      
      private var _dataVo:QPTrackingDataItemVO = null;
      
      private var displayObjectsAlphaChange:Vector.<DisplayObject> = null;
      
      public function QuestTrackingButton()
      {
         super();
         soundType = SoundTypes.RNDR_NORMAL;
         preventAutosizing = true;
         constraintsDisabled = true;
         this.trackingImg.visible = false;
         this.onPause.visible = false;
         this.displayObjectsAlphaChange = new <DisplayObject>[this.border,this.onPause,this.operationName,this.missionName,this.vehicle,bgMc];
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         toggle = true;
         tabEnabled = false;
         removeEventListener(InputEvent.INPUT,handleInput,false);
      }
      
      override protected function onDispose() : void
      {
         this.displayObjectsAlphaChange.splice(0,this.displayObjectsAlphaChange.length);
         this.displayObjectsAlphaChange = null;
         this.onPause.dispose();
         this.onPause = null;
         this.border = null;
         this.trackingImg = null;
         this.operationName = null;
         this.missionName = null;
         this.vehicle = null;
         this.disabled = null;
         this.bg = null;
         this._dataVo = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:DisplayObject = null;
         super.draw();
         if(isInvalid(SELECTED_STATE_INV))
         {
            _loc1_ = !!_selected ? Number(Values.DEFAULT_ALPHA) : Number(INACTIVE_ALPHA);
            for each(_loc2_ in this.displayObjectsAlphaChange)
            {
               _loc2_.alpha = _loc1_;
            }
         }
      }
      
      override protected function updateText() : void
      {
         super.updateText();
         if(this._dataVo)
         {
            this.missionName.text = this._dataVo.missionName;
            this.operationName.text = this._dataVo.operationName;
            this.trackingImg.visible = this._dataVo.eyeBtnVisible;
            this.vehicle.imageName = this._dataVo.vehicle;
            this.onPause.visible = this._dataVo.onPause;
         }
      }
      
      override protected function showTooltip() : void
      {
         if(this._dataVo && App.toolTipMgr && this._dataVo.onPause)
         {
            App.toolTipMgr.showComplex(TOOLTIPS.QUESTPROGRESSTRACKING_STATUS_ONPAUSE);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         if(this._dataVo != param1 && param1 != null)
         {
            this._dataVo = QPTrackingDataItemVO(param1);
            this.selected = this._dataVo.selected;
            super.data = param1;
            invalidateData();
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         if(_selected == param1)
         {
            return;
         }
         super.selected = param1;
         invalidate(SELECTED_STATE_INV);
      }
      
      public function get questId() : uint
      {
         return Boolean(this._dataVo) ? uint(this._dataVo.questID) : uint(Values.DEFAULT_INT);
      }
      
      public function get fullMissionName() : String
      {
         return Boolean(this._dataVo) ? this._dataVo.fullMissionName : Values.EMPTY_STR;
      }
   }
}
