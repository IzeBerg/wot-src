package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   import flash.filters.BitmapFilter;
   import net.wg.gui.components.minimap.interfaces.IMinimapEntry;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class MinimapEntry extends UIComponentEx implements IMinimapEntry
   {
       
      
      public var player:MovieClip;
      
      public var selfIcon:MovieClip;
      
      public var markMC:MovieClip;
      
      public var teamPoint:MovieClip;
      
      public var backMarker:MovieClip;
      
      public var m_type:String = "";
      
      private var _entryName:String = "";
      
      private var _vehicleClass:String = "";
      
      private var _markLabel:String = "";
      
      private var _isDead:Boolean = false;
      
      private var _isDeadPermanent:Boolean = false;
      
      private var _isPostmortem:Boolean = false;
      
      private const TEAM_POINT_PREFIX:String = "teamPoint";
      
      private const BACK_MARKER_PREFIX:String = "backMarker";
      
      public function MinimapEntry()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.player = null;
         this.selfIcon = null;
         this.markMC = null;
         this.teamPoint = null;
         this.backMarker = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:BitmapFilter = null;
         var _loc4_:String = null;
         this.updateType();
         this.updateIfEntryIsPlayer();
         if(this.selfIcon != null)
         {
            this.selfIcon.gotoAndStop(this._entryName);
            if(this.rotation != 0)
            {
               this.markMC.rotation = -this.rotation;
            }
         }
         if(this.isTeamPoint())
         {
            this.teamPoint.gotoAndStop(this._entryName);
            _loc1_ = this.TEAM_POINT_PREFIX + this._entryName + this._vehicleClass;
            _loc2_ = App.colorSchemeMgr.getAliasColor(_loc1_);
            _loc3_ = App.colorSchemeMgr.getScheme(_loc1_).adjustOffset;
            this.teamPoint.pointType.gotoAndStop(_loc2_);
            this.teamPoint.pointType.teamColor.gotoAndStop(this._markLabel);
            if(_loc3_ != null)
            {
               this.teamPoint.pointType.teamColor.filters = [_loc3_];
            }
            else
            {
               this.teamPoint.pointType.teamColor.filters = [];
            }
         }
         else if(this.isBackMarker())
         {
            this.backMarker.gotoAndStop(this._entryName);
            _loc4_ = App.colorSchemeMgr.getAliasColor(this.BACK_MARKER_PREFIX + this._entryName + this._markLabel);
            this.backMarker.marker.gotoAndStop(_loc4_);
         }
         else if(this.markMC != null)
         {
            if(this._markLabel != null)
            {
               this.markMC.gotoAndStop(this._markLabel);
            }
         }
         super.draw();
      }
      
      public function init(param1:String, param2:String, param3:String, param4:String) : void
      {
         this.m_type = param1;
         this._entryName = param2;
         this._vehicleClass = param3;
         this._markLabel = param4;
         this.validateNow();
      }
      
      public function isTeamPoint() : Boolean
      {
         return this.m_type == "points" && this.teamPoint != null;
      }
      
      public function update(param1:Object) : void
      {
         invalidate();
      }
      
      private function playPlayer() : void
      {
         this.player.litIcon.play();
         App.utils.scheduler.cancelTask(this.playPlayer);
      }
      
      private function isBackMarker() : Boolean
      {
         return this.m_type == "backgroundMarker" && this.backMarker != null;
      }
      
      private function updateType() : void
      {
         if(this.m_type != null)
         {
            gotoAndStop(this.m_type);
         }
      }
      
      private function updateIfEntryIsPlayer() : void
      {
         var _loc1_:String = null;
         if(this.player != null)
         {
            _loc1_ = App.colorSchemeMgr.getAliasColor(this.colorSchemeName);
            if(!this._isDead)
            {
               if(this._isPostmortem)
               {
                  this.player.gotoAndStop("postmortem");
               }
               else
               {
                  if(_loc1_ != null)
                  {
                     this.player.gotoAndStop(_loc1_);
                  }
                  this.player.litIcon.icon.gotoAndStop(this._vehicleClass);
               }
            }
            else
            {
               _loc1_ = _loc1_ != null ? _loc1_ : "green";
               this.player.gotoAndStop("dead");
               this.player.icon.marker.gotoAndStop(this._vehicleClass + "-" + _loc1_);
               this.player.icon.gotoAndPlay("show");
               this.player.icon.isDeadPermanent = this._isDeadPermanent;
            }
         }
      }
      
      public function get colorSchemeName() : String
      {
         return "vm_" + (this._entryName != null ? this._entryName : this.m_type);
      }
   }
}
