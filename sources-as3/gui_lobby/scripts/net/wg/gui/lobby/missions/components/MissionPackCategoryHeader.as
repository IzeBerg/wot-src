package net.wg.gui.lobby.missions.components
{
   import net.wg.gui.lobby.missions.components.headerComponents.HeaderDescBlock;
   import net.wg.gui.lobby.missions.data.MissionPackCategoryHeaderVO;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionPackCategoryHeader extends MissionPackHeaderBase
   {
      
      private static const HEIGHT:int = 145;
       
      
      public var descBlock:HeaderDescBlock;
      
      public function MissionPackCategoryHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         height = HEIGHT;
      }
      
      override protected function onDispose() : void
      {
         this.descBlock.dispose();
         this.descBlock = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:MissionPackCategoryHeaderVO = null;
         super.draw();
         if(data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = MissionPackCategoryHeaderVO(data);
            this.descBlock.update(_loc1_.descBlockVO);
            this.descBlock.validateNow();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.descBlock.width = width;
         }
      }
      
      override protected function get dataClass() : Class
      {
         return MissionPackCategoryHeaderVO;
      }
   }
}
