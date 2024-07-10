package net.wg.gui.battle.races.views
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.InvalidationType;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.infrastructure.base.meta.impl.RacesBattleLoadingMeta;
   import net.wg.infrastructure.interfaces.IDAAPIDataClass;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.controls.StatusIndicator;
   
   public class RacesBattleLoading extends RacesBattleLoadingMeta
   {
      
      private static const TIPS_SIZE:Object = {};
      
      private static const TIPS_WIDTH:Object = {};
      
      private static const TIPS_LEFT:Object = {};
      
      private static const TIPS_BOTTOM:Object = {};
      
      private static const LOADING_BAR_WIDTH:int = 704;
      
      private static const LOADING_BAR_PADDING_BOTTOM:int = 44;
      
      public static const PROGRESS:int = InvalidationType.SYSTEM_FLAGS_BORDER << 1;
      
      {
         TIPS_SIZE[StageSizeBoundaries.WIDTH_1024] = [18,15,18];
         TIPS_SIZE[StageSizeBoundaries.WIDTH_1366] = [18,15,18];
         TIPS_SIZE[StageSizeBoundaries.WIDTH_1600] = [28,22,28];
         TIPS_SIZE[StageSizeBoundaries.WIDTH_1920] = [28,22,28];
         TIPS_WIDTH[StageSizeBoundaries.WIDTH_1024] = 700;
         TIPS_WIDTH[StageSizeBoundaries.WIDTH_1366] = 800;
         TIPS_WIDTH[StageSizeBoundaries.WIDTH_1600] = 1000;
         TIPS_WIDTH[StageSizeBoundaries.WIDTH_1920] = 1000;
         TIPS_LEFT[StageSizeBoundaries.WIDTH_1024] = 80;
         TIPS_LEFT[StageSizeBoundaries.WIDTH_1366] = 80;
         TIPS_LEFT[StageSizeBoundaries.WIDTH_1600] = 160;
         TIPS_LEFT[StageSizeBoundaries.WIDTH_1920] = 160;
         TIPS_BOTTOM[StageSizeBoundaries.WIDTH_1024] = [16,40,40];
         TIPS_BOTTOM[StageSizeBoundaries.WIDTH_1366] = [16,40,40];
         TIPS_BOTTOM[StageSizeBoundaries.WIDTH_1600] = [12,40,40];
         TIPS_BOTTOM[StageSizeBoundaries.WIDTH_1920] = [12,40,40];
      }
      
      public var loadingBar:StatusIndicator = null;
      
      public var tip1:TextField = null;
      
      public var tip2:TextField = null;
      
      public var tip3:TextField = null;
      
      private var _height:int = 0;
      
      private var _width:int = 0;
      
      private var _state:int = 1024;
      
      private var _tips:Vector.<TextField> = null;
      
      private var _tipsData:Vector.<String> = null;
      
      private var _tipsLength:int = 0;
      
      private var _progress:Number = 0;
      
      public function RacesBattleLoading()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         var _loc1_:TextField = null;
         super.configUI();
         this.loadingBar.setActualSize(LOADING_BAR_WIDTH,this.loadingBar.actualHeight);
         this._tips = new <TextField>[this.tip1,this.tip2,this.tip3];
         this._tipsLength = this._tips.length;
         for each(_loc1_ in this._tips)
         {
            _loc1_.wordWrap = true;
            _loc1_.autoSize = TextFieldAutoSize.LEFT;
         }
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:TextFormat = null;
         var _loc4_:TextField = null;
         var _loc5_:int = 0;
         super.draw();
         if(this._progress > 0 && isInvalid(PROGRESS))
         {
            this.loadingBar.position = this._progress;
         }
         if(this._width > 0)
         {
            if(this._tipsData && isInvalid(InvalidationType.DATA))
            {
               _loc1_ = 0;
               while(_loc1_ < this._tipsLength)
               {
                  this._tips[_loc1_].text = this._tipsData[_loc1_];
                  _loc1_++;
               }
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               if(this._width >= StageSizeBoundaries.WIDTH_1920 && this._height >= StageSizeBoundaries.HEIGHT_1080)
               {
                  this._state = StageSizeBoundaries.WIDTH_1920;
               }
               else if(this._width >= StageSizeBoundaries.WIDTH_1600 && this._height >= StageSizeBoundaries.HEIGHT_900)
               {
                  this._state = StageSizeBoundaries.WIDTH_1600;
               }
               else if(this._width >= StageSizeBoundaries.WIDTH_1366)
               {
                  this._state = StageSizeBoundaries.WIDTH_1366;
               }
               else
               {
                  this._state = StageSizeBoundaries.WIDTH_1024;
               }
               _loc2_ = this._height - this.loadingBar.actualHeight - LOADING_BAR_PADDING_BOTTOM;
               this.loadingBar.y = _loc2_;
               this.loadingBar.x = this._width - LOADING_BAR_WIDTH >> 1;
               _loc5_ = this._tipsLength - 1;
               while(_loc5_ >= 0)
               {
                  _loc4_ = this._tips[_loc5_];
                  _loc3_ = _loc4_.getTextFormat();
                  _loc3_.size = TIPS_SIZE[this._state][_loc5_];
                  _loc4_.setTextFormat(_loc3_);
                  _loc4_.width = TIPS_WIDTH[this._state];
                  _loc4_.x = TIPS_LEFT[this._state];
                  _loc4_.y = _loc2_ - _loc4_.height - TIPS_BOTTOM[this._state][_loc5_];
                  _loc2_ = _loc4_.y;
                  _loc5_--;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.loadingBar.dispose();
         this.loadingBar = null;
         this.tip1 = null;
         this.tip2 = null;
         this.tip3 = null;
         this._tips.length = 0;
         this._tips = null;
         this._tipsData = null;
         super.onDispose();
      }
      
      override public function as_setProgress(param1:Number) : void
      {
         if(param1 != this._progress)
         {
            this._progress = param1;
            invalidate(PROGRESS);
         }
      }
      
      override public function getContentY() : int
      {
         return this.loadingBar.y;
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         super.updateStage(param1,param2);
         if(this._width != param1 || this._height != param2)
         {
            this._width = param1;
            this._height = param2;
            invalidateSize();
         }
      }
      
      override protected function setTips(param1:Vector.<String>) : void
      {
         if(this._tipsData != param1 && param1 != null)
         {
            this._tipsData = param1;
            invalidateData();
         }
      }
      
      override public function addVehiclesInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function as_setMapIcon(param1:String) : void
      {
      }
      
      override public function as_setTip(param1:String) : void
      {
      }
      
      override public function as_setTipTitle(param1:String) : void
      {
      }
      
      override public function setArenaInfo(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setFrags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setPersonalStatus(param1:uint) : void
      {
      }
      
      override public function setQuestStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function setVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateInvitationsStatuses(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updatePersonalStatus(param1:uint, param2:uint) : void
      {
      }
      
      override public function updatePlayerStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateUserTags(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehicleStatus(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehiclesData(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateVehiclesStat(param1:IDAAPIDataClass) : void
      {
      }
      
      override public function updateTriggeredChatCommands(param1:IDAAPIDataClass) : void
      {
      }
      
      override protected function setVisualTipInfo(param1:VisualTipInfoVO) : void
      {
      }
      
      override public function hasAmmunitionPanel(param1:Boolean) : void
      {
      }
   }
}
