package net.wg.gui.components.tooltips
{
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.tooltips.VO.SortieDivisionVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.gui.components.tooltips.sortie.SortieDivisionBlock;
   import net.wg.utils.ILocale;
   import scaleform.clik.utils.Padding;
   
   public class ToolTipSortieDivision extends ToolTipBase
   {
      
      private static const TEXT_PADDING:int = 5;
       
      
      public var headerTF:TextField = null;
      
      public var middleDiv:SortieDivisionBlock = null;
      
      private var _division:SortieDivisionBlock = null;
      
      public function ToolTipSortieDivision()
      {
         super();
         this.headerTF = content.headerTF;
         this.middleDiv = content.middleDiv;
         this._division = this.middleDiv;
         contentMargin = new Padding(9,18,10,15);
      }
      
      override protected function redraw() : void
      {
         var _loc1_:SortieDivisionVO = null;
         var _loc2_:int = 0;
         var _loc3_:ILocale = null;
         _loc1_ = new SortieDivisionVO(_data);
         _loc2_ = bgShadowMargin.left + contentMargin.left;
         _loc3_ = App.utils.locale;
         separators = new Vector.<Separator>();
         this.headerTF.text = _loc3_.makeString(_loc1_.divisions[0].divisName);
         this.headerTF.width = this.headerTF.textWidth + TEXT_PADDING;
         this.headerTF.x = _loc2_;
         this.headerTF.y = topPosition ^ 0;
         topPosition += this.headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK;
         this._division.x = _loc2_;
         this._division.division = _loc3_.makeString(_loc1_.divisions[0].divisName);
         this._division.divisionLvls = _loc1_.divisions[0].divisLevels;
         this._division.playersLimit = _loc1_.divisions[0].divisPlayers;
         this._division.divisionLegionnaires = _loc1_.divisions[0].divisLegionnaires;
         this._division.divisionTime = _loc1_.divisions[0].divisTime;
         this._division.bonus = _loc1_.divisions[0].dailyBonus;
         this._division.isSortie = _loc1_.divisions[0].isSortie;
         if(this._division.bonus == Values.EMPTY_STR)
         {
            this._division.y = topPosition - 40;
         }
         else
         {
            this._division.y = topPosition;
         }
         topPosition += this._division.height;
         _loc1_.dispose();
         _loc1_ = null;
         super.redraw();
      }
      
      override protected function onDispose() : void
      {
         this.headerTF = null;
         this._division = null;
         if(this.middleDiv)
         {
            this.middleDiv.dispose();
            this.middleDiv = null;
         }
         super.onDispose();
      }
   }
}
