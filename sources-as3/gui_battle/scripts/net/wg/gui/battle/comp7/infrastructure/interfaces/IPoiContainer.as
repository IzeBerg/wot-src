package net.wg.gui.battle.comp7.infrastructure.interfaces
{
   import net.wg.gui.battle.comp7.VO.daapi.Comp7InterestPointVO;
   
   public interface IPoiContainer
   {
       
      
      function removePointOfInterest(param1:uint, param2:uint) : void;
      
      function updatePointOfInterest(param1:Comp7InterestPointVO, param2:Boolean = true) : void;
   }
}
