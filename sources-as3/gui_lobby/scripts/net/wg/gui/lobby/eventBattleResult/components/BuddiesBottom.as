package net.wg.gui.lobby.eventBattleResult.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.lobby.eventBattleResult.data.TeamStatsVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ILocale;
   import scaleform.clik.constants.InvalidationType;
   
   public class BuddiesBottom extends UIComponentEx
   {
      
      private static const KEY_CENTER_X:int = 766;
      
      private static const ICON_GAP:int = 3;
       
      
      public var soulsTF:TextField = null;
      
      public var killsTF:TextField = null;
      
      public var damageTF:TextField = null;
      
      public var blockedTF:TextField = null;
      
      public var keysTF:TextField = null;
      
      public var resultTF:TextField = null;
      
      public var keyMC:MovieClip = null;
      
      private var _data:TeamStatsVO = null;
      
      private var _locale:ILocale;
      
      public function BuddiesBottom()
      {
         this._locale = App.utils.locale;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.resultTF.text = EVENT.RESULTSCREEN_TAB_1;
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.soulsTF.text = this._locale.integer(this._data.matter);
            this.killsTF.text = this._locale.integer(this._data.kills);
            this.damageTF.text = this._locale.integer(this._data.damage);
            this.blockedTF.text = this._locale.integer(this._data.blocked);
            this.keysTF.text = this._locale.integer(this._data.keys);
            _loc1_ = this.keysTF.textWidth + this.keyMC.width;
            this.keysTF.x = KEY_CENTER_X - (_loc1_ >> 1);
            this.keyMC.x = this.keysTF.x + this.keysTF.textWidth + ICON_GAP | 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this.soulsTF = null;
         this.killsTF = null;
         this.damageTF = null;
         this.blockedTF = null;
         this.keysTF = null;
         this.resultTF = null;
         this.keyMC = null;
         this._data = null;
         this._locale = null;
         super.onDispose();
      }
      
      public function setData(param1:TeamStatsVO) : void
      {
         this._data = param1;
         invalidateData();
      }
   }
}
