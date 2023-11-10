package net.wg.gui.bootcamp.battleResult.interfaces
{
   import net.wg.gui.bootcamp.battleResult.data.BattleItemRendererVO;
   import net.wg.infrastructure.interfaces.IUIComponentEx;
   
   public interface IBattleResultRenderer extends IUIComponentEx
   {
       
      
      function setData(param1:BattleItemRendererVO) : void;
   }
}
