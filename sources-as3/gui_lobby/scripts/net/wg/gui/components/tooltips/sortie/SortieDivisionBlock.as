package net.wg.gui.components.tooltips.sortie
{
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class SortieDivisionBlock extends UIComponentEx
   {
       
      
      public var levelsTF:TextField = null;
      
      public var legionnairesTF:TextField = null;
      
      public var playersTF:TextField = null;
      
      public var timeTF:TextField = null;
      
      public var bonusTF:TextField = null;
      
      public var levelsIT:TextField = null;
      
      public var legionnairesIT:TextField = null;
      
      public var playersIT:TextField = null;
      
      public var timeIT:TextField = null;
      
      public var bonusIT:TextField = null;
      
      private var _division:String = "";
      
      private var _divisionLvls:String = "";
      
      private var _playersLimit:String = "";
      
      private var _divisionBonus:String = "";
      
      private var _divisionLegionnaires:String = "";
      
      private var _divisionTime:String = "";
      
      private var _bonus:String = "";
      
      private var _isSortie:Boolean = false;
      
      public function SortieDivisionBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.levelsTF.text = TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_VEHLEVEL;
         this.legionnairesTF.text = TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_LEGIONNAIRESLIMIT;
         this.playersTF.text = TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_PLAYERSLIMIT;
         this.timeTF.text = TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_TIMELIMIT;
         this.bonusTF.text = TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_DOUBLEBONUS;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.levelsIT.htmlText = this._divisionLvls;
            this.playersIT.htmlText = this._playersLimit;
            this.legionnairesIT.htmlText = this._divisionLegionnaires;
            this.timeIT.htmlText = this._divisionTime;
            this.timeTF.text = !!this._isSortie ? TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_TIMELIMITSORTIE : TOOLTIPS.FORTIFICATION_SORTIEDIVISIONTOOLTIP_TIMELIMIT;
            if(this._bonus == Values.EMPTY_STR)
            {
               this.bonusIT.visible = false;
               this.bonusTF.visible = false;
            }
            else
            {
               this.bonusIT.htmlText = this._bonus;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.levelsTF = null;
         this.legionnairesTF = null;
         this.playersTF = null;
         this.timeTF = null;
         this.bonusTF = null;
         this.levelsIT = null;
         this.legionnairesIT = null;
         this.playersIT = null;
         this.timeIT = null;
         this.bonusIT = null;
         super.onDispose();
      }
      
      public function get division() : String
      {
         return this._division;
      }
      
      public function set division(param1:String) : void
      {
         this._division = param1;
         invalidateData();
      }
      
      public function get divisionLvls() : String
      {
         return this._divisionLvls;
      }
      
      public function set divisionLvls(param1:String) : void
      {
         this._divisionLvls = param1;
         invalidateData();
      }
      
      public function get divisionBonus() : String
      {
         return this._divisionBonus;
      }
      
      public function set divisionBonus(param1:String) : void
      {
         this._divisionBonus = param1;
         invalidateData();
      }
      
      public function get playersLimit() : String
      {
         return this._playersLimit;
      }
      
      public function set playersLimit(param1:String) : void
      {
         this._playersLimit = param1;
         invalidateData();
      }
      
      public function get divisionLegionnaires() : String
      {
         return this._divisionLegionnaires;
      }
      
      public function set divisionLegionnaires(param1:String) : void
      {
         this._divisionLegionnaires = param1;
         invalidateData();
      }
      
      public function get divisionTime() : String
      {
         return this._divisionTime;
      }
      
      public function set divisionTime(param1:String) : void
      {
         this._divisionTime = param1;
         invalidateData();
      }
      
      public function get isSortie() : Boolean
      {
         return this._isSortie;
      }
      
      public function set isSortie(param1:Boolean) : void
      {
         this._isSortie = param1;
         invalidateData();
      }
      
      public function get bonus() : String
      {
         return this._bonus;
      }
      
      public function set bonus(param1:String) : void
      {
         this._bonus = param1;
         invalidateData();
      }
   }
}
