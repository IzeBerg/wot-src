package net.wg.gui.lobby.missions.components
{
   import net.wg.gui.lobby.missions.components.headerComponents.DebutBoxHeaderDescBlock;
   import net.wg.gui.lobby.missions.components.headerComponents.DebutBoxHeaderTitleBlock;
   import net.wg.gui.lobby.missions.data.MissionPackDebutBoxHeaderVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionPackDebutBoxesHeader extends MissionPackHeaderBase
   {
      
      private static const HEIGHT:int = 405;
      
      private static const HEIGHT_DISABLED:int = 300;
       
      
      public var descBlock:DebutBoxHeaderDescBlock;
      
      private var _debutBoxTitleBlock:DebutBoxHeaderTitleBlock;
      
      public function MissionPackDebutBoxesHeader()
      {
         super();
         this._debutBoxTitleBlock = DebutBoxHeaderTitleBlock(titleBlock);
      }
      
      override protected function onDispose() : void
      {
         this.descBlock.dispose();
         this.descBlock = null;
         this._debutBoxTitleBlock = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:MissionPackDebutBoxHeaderVO = null;
         super.draw();
         if(data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = MissionPackDebutBoxHeaderVO(data);
            height = !!_loc1_.isEnabled ? Number(HEIGHT) : Number(HEIGHT_DISABLED);
            this._debutBoxTitleBlock.isEnabled = _loc1_.isEnabled;
            this.descBlock.update(_loc1_.descBlockVO);
            this.descBlock.isEnabled = _loc1_.isEnabled;
            this.descBlock.validateNow();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.descBlock.width = width;
         }
      }
      
      override protected function get dataClass() : Class
      {
         return MissionPackDebutBoxHeaderVO;
      }
   }
}
