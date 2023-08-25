package net.wg.gui.bootcamp.battleResult.containers.base
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.bootcamp.battleResult.data.BattleItemRendererVO;
   import net.wg.gui.bootcamp.battleResult.events.BattleViewEvent;
   import net.wg.gui.bootcamp.battleResult.interfaces.IBattleResultRenderer;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class BaseRendererContainer extends UIComponentEx implements IUpdatable
   {
       
      
      public var renderer:IBattleResultRenderer = null;
      
      private var _data:BattleItemRendererVO = null;
      
      public function BaseRendererContainer()
      {
