package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   import flash.filters.BitmapFilter;
   import net.wg.data.constants.generated.MINIMAPENTRIES_CONSTANTS;
   import net.wg.gui.components.minimap.interfaces.IMinimapEntry;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class MinimapEntry extends UIComponentEx implements IMinimapEntry
   {
      
      private static const TEAM_POINT_PREFIX:String = "teamPoint";
      
      private static const BACK_MARKER_PREFIX:String = "backMarker";
      
      private static const COLOR_SCHEME_PREFIX:String = "vm_";
       
      
      public var player:MovieClip;
      
      public var selfIcon:MovieClip;
      
      public var markMC:MovieClip;
      
      public var teamPoint:MovieClip;
      
      public var backMarker:MovieClip;
      
      public var poi:MovieClip;
      
      public var m_type:String = "";
      
      private var _entryName:String = "";
      
      private var _vehicleClass:String = "";
      
      private var _markLabel:String = "";
      
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
         this.poi = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this.markMC)
         {
            this.markMC.stop();
         }
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
            _loc1_ = TEAM_POINT_PREFIX + this._entryName + this._vehicleClass;
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
            _loc4_ = App.colorSchemeMgr.getAliasColor(BACK_MARKER_PREFIX + this._entryName + this._markLabel);
            this.backMarker.marker.gotoAndStop(_loc4_);
         }
         else if(this.isPoi())
         {
            this.markMC.gotoAndStop(1);
            this.poi.gotoAndStop(this._entryName);
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
         return this.m_type == MINIMAPENTRIES_CONSTANTS.MARKER_TYPE_POINT && this.teamPoint != null;
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
         return this.m_type == MINIMAPENTRIES_CONSTANTS.MARKER_TYPE_BACKGROUND_MARKER && this.backMarker != null;
      }
      
      private function isPoi() : Boolean
      {
         return this.m_type == MINIMAPENTRIES_CONSTANTS.MARKER_TYPE_POI && this.poi != null;
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
            if(StringUtils.isNotEmpty(_loc1_))
            {
               this.player.gotoAndStop(_loc1_);
            }
            this.player.litIcon.icon.gotoAndStop(this._vehicleClass);
         }
      }
      
      public function get colorSchemeName() : String
      {
         return COLOR_SCHEME_PREFIX + (this._entryName != null ? this._entryName : this.m_type);
      }
   }
}
