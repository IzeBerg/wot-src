package net.wg.gui.battle.views.epicRespawnView.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.battle.views.epicRespawnView.data.RespawnPointVO;
   import net.wg.gui.battle.views.epicRespawnView.events.EpicRespawnEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.MouseEventEx;
   
   public class EpicRespawnMapEntriesContainer extends Sprite implements IDisposable
   {
      
      private static const RESPAWN_POINT_LINKAGE:String = "EpicRespawnPointUI";
      
      private static const LOCK_REASON_ORIGINAL_WIDTH:uint = 180;
      
      private static const LOCK_REASON_BORDER:int = 10;
      
      private static const LOCKED_BG_PADDING:int = 20;
      
      private static const NUMBER_OF_LANES:uint = 3;
       
      
      public var bounds:Sprite;
      
      public var lane1TF:TextField;
      
      public var lane2TF:TextField;
      
      public var lane3TF:TextField;
      
      public var lockReason1MC:MovieClip;
      
      public var lockReason2MC:MovieClip;
      
      public var lockReason3MC:MovieClip;
      
      public var lockedBg1MC:MovieClip;
      
      public var lockedBg2MC:MovieClip;
      
      public var lockedBg3MC:MovieClip;
      
      private var _baseDisposed:Boolean = false;
      
      private var _respawnPoints:Vector.<EpicRespawnPoint> = null;
      
      private var _locationsVO:Vector.<RespawnPointVO> = null;
      
      private var _lockReasonList:Vector.<MovieClip> = null;
      
      private var _lockedBgList:Vector.<MovieClip> = null;
      
      private var _selectedIdx:int = -1;
      
      public function EpicRespawnMapEntriesContainer()
      {
         super();
         this._respawnPoints = new Vector.<EpicRespawnPoint>();
         this._lockReasonList = new <MovieClip>[this.lockReason1MC,this.lockReason2MC,this.lockReason3MC];
         this._lockedBgList = new <MovieClip>[this.lockedBg1MC,this.lockedBg2MC,this.lockedBg3MC];
         this.hitArea = this.bounds;
         this.mouseEnabled = false;
         this.mouseChildren = true;
         this.addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.lane1TF.autoSize = this.lane2TF.autoSize = this.lane3TF.autoSize = TextFieldAutoSize.CENTER;
         this.lane1TF.text = EPIC_BATTLE.RESPAWNSCREEN_DEPLOYMENTLANE1;
         this.lane2TF.text = EPIC_BATTLE.RESPAWNSCREEN_DEPLOYMENTLANE2;
         this.lane3TF.text = EPIC_BATTLE.RESPAWNSCREEN_DEPLOYMENTLANE3;
      }
      
      protected function onDispose() : void
      {
         var _loc1_:EpicRespawnPoint = null;
         this.removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         for each(_loc1_ in this._respawnPoints)
         {
            this.removeChild(_loc1_);
            _loc1_.dispose();
         }
         this._respawnPoints.splice(0,this._respawnPoints.length);
         this._respawnPoints = null;
         this._lockReasonList.splice(0,this._lockReasonList.length);
         this._lockReasonList = null;
         this._lockedBgList.splice(0,this._lockedBgList.length);
         this._lockedBgList = null;
         this._locationsVO = null;
         this.lockReason1MC = this.lockReason2MC = this.lockReason3MC = null;
         this.lockedBg1MC = this.lockedBg2MC = this.lockedBg3MC = null;
         this.lane1TF = this.lane2TF = this.lane3TF = null;
         this.bounds = null;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function setRespawnLocations(param1:Vector.<RespawnPointVO>) : void
      {
         var _loc4_:EpicRespawnPoint = null;
         var _loc5_:RespawnPointVO = null;
         this._locationsVO = param1;
         var _loc2_:uint = this._respawnPoints.length;
         var _loc3_:uint = this._locationsVO.length;
         _loc4_ = null;
         _loc5_ = null;
         var _loc6_:uint = _loc3_;
         while(_loc6_ < _loc2_)
         {
            _loc4_ = this._respawnPoints[_loc6_];
            _loc4_.visible = false;
            _loc6_++;
         }
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = this._locationsVO[_loc6_];
            if(_loc6_ == this._respawnPoints.length)
            {
               this.addRespawnPoint();
            }
            _loc4_ = this._respawnPoints[_loc6_];
            _loc4_.x = _loc5_.x * this.bounds.width | 0;
            _loc4_.y = (1 - _loc5_.y) * this.bounds.height | 0;
            _loc4_.showWarning = _loc5_.isEnemyNear;
            _loc4_.visible = true;
            _loc6_++;
         }
      }
      
      public function setSelectedLocation(param1:int) : void
      {
         if(this._locationsVO == null || param1 == this._selectedIdx)
         {
            return;
         }
         if(this._selectedIdx >= 0 && this._selectedIdx < this._respawnPoints.length)
         {
            this._respawnPoints[this._selectedIdx].setSelectedState(false);
         }
         this._selectedIdx = param1;
         if(this._selectedIdx >= 0 && this._selectedIdx < this._locationsVO.length)
         {
            this._respawnPoints[this._selectedIdx].setSelectedState(true);
         }
      }
      
      public function setLaneLockedState(param1:int, param2:Boolean, param3:String) : void
      {
         this._lockReasonList[param1].visible = this._lockedBgList[param1].visible = param2;
         this._lockReasonList[param1].lockedTF.text = param3;
      }
      
      public function get selectedPointVO() : RespawnPointVO
      {
         if(this._selectedIdx >= 0 && this._selectedIdx < this._locationsVO.length)
         {
            return this._locationsVO[this._selectedIdx];
         }
         return null;
      }
      
      public function setBounds(param1:Number, param2:Number) : void
      {
         var _loc4_:Number = NaN;
         if(param1 == this.bounds.width && param2 == this.bounds.height)
         {
            return;
         }
         this.bounds.width = param1;
         this.bounds.height = param2;
         var _loc3_:uint = this._locationsVO != null ? uint(this._locationsVO.length) : uint(0);
         _loc4_ = this.bounds.width / NUMBER_OF_LANES;
         var _loc5_:Number = 0.5 * _loc4_;
         var _loc6_:int = this.bounds.width >> 1;
         var _loc7_:EpicRespawnPoint = null;
         var _loc8_:RespawnPointVO = null;
         var _loc9_:uint = 0;
         while(_loc9_ < _loc3_)
         {
            _loc7_ = this._respawnPoints[_loc9_];
            _loc8_ = this._locationsVO[_loc9_];
            _loc7_.x = _loc8_.x * this.bounds.width | 0;
            _loc7_.y = (1 - _loc8_.y) * this.bounds.height | 0;
            _loc9_++;
         }
         this.lane1TF.x = this.lockReason1MC.x = _loc5_ | 0;
         this.lane2TF.x = this.lockReason2MC.x = _loc6_;
         this.lane3TF.x = this.lockReason3MC.x = this.bounds.width - _loc5_ | 0;
         this.lockReason1MC.y = this.lockReason2MC.y = this.lockReason3MC.y = this.bounds.height >> 1;
         if(_loc4_ < LOCK_REASON_ORIGINAL_WIDTH + LOCK_REASON_BORDER)
         {
            this.lockReason1MC.width = this.lockReason2MC.width = this.lockReason3MC.width = _loc4_ - LOCK_REASON_BORDER;
            this.lockReason1MC.scaleY = this.lockReason2MC.scaleY = this.lockReason3MC.scaleY = this.lockReason1MC.scaleX;
         }
         else
         {
            this.lockReason1MC.scaleX = this.lockReason1MC.scaleY = this.lockReason2MC.scaleX = this.lockReason2MC.scaleY = this.lockReason3MC.scaleX = this.lockReason3MC.scaleY = 1;
         }
         this.lockedBg1MC.width = this.lockedBg2MC.width = this.lockedBg3MC.width = _loc4_ + LOCKED_BG_PADDING | 0;
         this.lockedBg1MC.height = this.lockedBg2MC.height = this.lockedBg3MC.height = this.bounds.height + LOCKED_BG_PADDING | 0;
         this.lockedBg2MC.x = this.lockedBg1MC.x + _loc4_;
         this.lockedBg3MC.x = this.lockedBg2MC.x + _loc4_;
      }
      
      private function addRespawnPoint() : void
      {
         var _loc1_:EpicRespawnPoint = App.utils.classFactory.getComponent(RESPAWN_POINT_LINKAGE,EpicRespawnPoint);
         this._respawnPoints.push(this.addChild(_loc1_));
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = Boolean(_loc2_) ? uint(_loc2_.buttonIdx) : uint(MouseEventEx.LEFT_BUTTON);
         if(_loc3_ != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         var _loc4_:EpicRespawnPoint = param1.target as EpicRespawnPoint;
         if(_loc4_ == null || _loc4_.selected)
         {
            return;
         }
         _loc4_.selected = true;
         if(this._selectedIdx >= 0 && this._selectedIdx < this._respawnPoints.length)
         {
            this._respawnPoints[this._selectedIdx].selected = false;
         }
         this._selectedIdx = this._respawnPoints.indexOf(_loc4_);
         this.dispatchEvent(new EpicRespawnEvent(EpicRespawnEvent.RESPAWN_LOCATION_SELECT,this._selectedIdx));
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
   }
}
