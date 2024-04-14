package net.wg.gui.lobby.rankedBattles19.components.rankAward
{
   import flash.geom.Point;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.rankedBattles19.components.ImageContainer;
   import net.wg.gui.lobby.rankedBattles19.data.AwardDivisionBaseVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class AwardDivisionBase extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const IMAGE_SIZE:String = "190x260";
      
      private static const IMAGE_POSITIONS:Point = new Point(-95,-130);
       
      
      public var division:ImageContainer = null;
      
      public var newDivision:ImageContainer = null;
      
      private var _data:AwardDivisionBaseVO = null;
      
      public function AwardDivisionBase()
      {
         super();
      }
      
      private static function getIcon(param1:int) : String
      {
         return RES_ICONS.maps_icons_rankedbattles_divisions_all_all_png(IMAGE_SIZE,String(param1));
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.division.setImgPoint(IMAGE_POSITIONS);
         this.newDivision.setImgPoint(IMAGE_POSITIONS);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.updateData();
         }
      }
      
      override protected function onDispose() : void
      {
         this.division.dispose();
         this.division = null;
         this.newDivision.dispose();
         this.newDivision = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null && this._data != param1)
         {
            this._data = AwardDivisionBaseVO(param1);
            invalidateData();
         }
      }
      
      protected function updateData() : void
      {
         this.division.setSource(getIcon(this._data.division));
         this.newDivision.setSource(getIcon(this._data.newDivision));
      }
      
      public function get data() : AwardDivisionBaseVO
      {
         return this._data;
      }
   }
}
