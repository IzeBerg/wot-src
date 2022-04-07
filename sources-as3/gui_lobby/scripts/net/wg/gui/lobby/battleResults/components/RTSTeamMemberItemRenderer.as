package net.wg.gui.lobby.battleResults.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.text.TextField;
   import net.wg.data.constants.ColorSchemeNames;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.battleResults.data.TeamMemberItemVO;
   import net.wg.infrastructure.interfaces.IColorScheme;
   import net.wg.utils.ILocale;
   
   public class RTSTeamMemberItemRenderer extends TeamMemberRendererBase
   {
      
      private static var _dimmFilter:ColorMatrixFilter = null;
      
      private static const DAMAGE_DEATH_COLOR:int = 6381391;
      
      private static const DAMAGE_DEFAULT_COLOR:int = 13413751;
      
      private static const DIMMED_COLOR_VALUE:Number = 0.4;
      
      private static const STATE_OUT:String = "out";
      
      private static const STATE_OVER:String = "over";
      
      private static const ZERO:String = "0";
       
      
      public var clickArea:MovieClip = null;
      
      public var selfBg:MovieClip = null;
      
      public var deadBg:MovieClip = null;
      
      public var separatorLbl:TextField = null;
      
      public var vehicleName:TextField = null;
      
      public var damageLbl:TextField = null;
      
      public var fragsLbl:TextField = null;
      
      public var fakeFocusIndicator:MovieClip = null;
      
      public var vehicleIcon:UILoaderAlt = null;
      
      private var _vo:TeamMemberItemVO = null;
      
      private var _locale:ILocale;
      
      public function RTSTeamMemberItemRenderer()
      {
         this._locale = App.utils.locale;
         super();
      }
      
      private static function getDimmFilter() : ColorMatrixFilter
      {
         var _loc1_:Array = null;
         var _loc2_:Array = null;
         var _loc3_:Array = null;
         var _loc4_:Array = null;
         var _loc5_:Array = null;
         if(_dimmFilter == null)
         {
            _dimmFilter = new ColorMatrixFilter();
            _loc1_ = [DIMMED_COLOR_VALUE,0,0,0,0];
            _loc2_ = [0,DIMMED_COLOR_VALUE,0,0,0];
            _loc3_ = [0,0,DIMMED_COLOR_VALUE,0,0];
            _loc4_ = [0,0,0,1,0];
            _loc5_ = [];
            _loc5_ = _loc5_.concat(_loc1_);
            _loc5_ = _loc5_.concat(_loc2_);
            _loc5_ = _loc5_.concat(_loc3_);
            _loc5_ = _loc5_.concat(_loc4_);
            _dimmFilter.matrix = _loc5_;
         }
         return _dimmFilter;
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         mouseChildren = param1;
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         super.handleMouseRollOver(param1);
         this.fakeFocusIndicator.gotoAndPlay(STATE_OVER);
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         super.handleMouseRollOut(param1);
         this.fakeFocusIndicator.gotoAndPlay(STATE_OUT);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         mouseChildren = true;
         hitArea = this.clickArea;
      }
      
      override protected function onDispose() : void
      {
         this.clickArea = null;
         this.selfBg = null;
         this.deadBg = null;
         this.separatorLbl = null;
         this.vehicleName = null;
         this.damageLbl = null;
         this.fragsLbl = null;
         this.fakeFocusIndicator = null;
         this.vehicleIcon.filters = [];
         this.vehicleIcon.dispose();
         this.vehicleIcon = null;
         this._locale = null;
         this._vo = null;
         super.onDispose();
      }
      
      override protected function showData(param1:TeamMemberItemVO) : void
      {
         this._vo = param1;
         var _loc2_:int = numChildren;
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            getChildAt(_loc3_).visible = !param1.isRTSSeparator;
            _loc3_++;
         }
         this.separatorLbl.visible = param1.isRTSSeparator;
         if(this.separatorLbl.visible)
         {
            this.separatorLbl.text = param1.rtsSeparatorLabel;
            return;
         }
         this.selfBg.visible = param1.isSelf;
         this.deadBg.visible = false;
         var _loc4_:IColorScheme = null;
         if(param1.isTeamKiller)
         {
            _loc4_ = App.colorSchemeMgr.getScheme(param1.deathReason > -1 ? ColorSchemeNames.TEAMKILLER_DEAD : ColorSchemeNames.TEAMKILLER);
         }
         else
         {
            _loc4_ = App.colorSchemeMgr.getScheme(param1.deathReason > -1 ? ColorSchemeNames.NORMAL_DEAD : ColorSchemeNames.NORMAL);
         }
         this.vehicleIcon.source = Boolean(param1.tankIcon) ? param1.tankIcon : this.vehicleIcon.sourceAlt;
         this.vehicleName.htmlText = param1.vehicleName;
         this.damageLbl.text = ZERO;
         this.vehicleName.textColor = _loc4_.rgb;
         this.fragsLbl.textColor = this.damageLbl.textColor = DAMAGE_DEFAULT_COLOR;
         if(param1.deathReason > -1)
         {
            this.damageLbl.textColor = DAMAGE_DEATH_COLOR;
            this.deadBg.visible = true;
            this.vehicleIcon.filters = [getDimmFilter()];
         }
         else
         {
            this.vehicleIcon.filters = [];
         }
         this.damageLbl.visible = param1.damageDealt != Values.DEFAULT_INT;
         if(param1.damageDealt > 0)
         {
            this.damageLbl.text = this._locale.integer(param1.damageDealt);
         }
         this.fragsLbl.visible = param1.kills > 0;
         if(this.fragsLbl.visible)
         {
            this.fragsLbl.text = param1.kills.toString();
         }
         if(param1.tkills > 0)
         {
            this.fragsLbl.textColor = getColorForAlias(ColorSchemeNames.TEAMKILLER,DEFAULT_TEAM_KILLER_COLOR);
         }
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         if(this._vo.isRTSSeparator)
         {
            return;
         }
         super.handleMouseRelease(param1);
      }
   }
}
