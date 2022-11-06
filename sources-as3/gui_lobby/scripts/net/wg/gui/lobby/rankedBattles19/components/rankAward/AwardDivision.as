package net.wg.gui.lobby.rankedBattles19.components.rankAward
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.lobby.rankedBattles19.data.AwardDivisionVO;
   
   public class AwardDivision extends AwardDivisionBase
   {
       
      
      public var nameMc:MovieClip = null;
      
      public var newNameMc:MovieClip = null;
      
      private var _nameTf:TextField = null;
      
      private var _newNameTf:TextField = null;
      
      public function AwardDivision()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._nameTf = this.nameMc.text;
         this._newNameTf = this.newNameMc.text;
      }
      
      override protected function updateData() : void
      {
         super.updateData();
         var _loc1_:AwardDivisionVO = AwardDivisionVO(data);
         this._nameTf.htmlText = _loc1_.divisionName;
         this._newNameTf.htmlText = _loc1_.newDivisionName;
      }
      
      override protected function onDispose() : void
      {
         this.nameMc = null;
         this.newNameMc = null;
         this._nameTf = null;
         this._newNameTf = null;
         super.onDispose();
      }
   }
}
