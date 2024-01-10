package net.wg.gui.lobby.rankedBattles19.components.divisionsContainer
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.interfaces.IGroupedControl;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.IndexEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class DivisionsContainer extends UIComponentEx implements IGroupedControl
   {
      
      private static const INV_SELECTED_INDEX:String = 