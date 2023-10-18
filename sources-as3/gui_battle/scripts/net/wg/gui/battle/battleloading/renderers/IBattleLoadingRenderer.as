package net.wg.gui.battle.battleloading.renderers
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IBattleLoadingRenderer extends IDisposable
   {
       
      
      function setData(param1:Object) : void;
      
      function set isExtendedLayout(param1:Boolean) : void;
   }
}
