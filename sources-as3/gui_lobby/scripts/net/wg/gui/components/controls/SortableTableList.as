package net.wg.gui.components.controls
{
   import flash.display.DisplayObject;
   import net.wg.gui.events.SortableTableListEvent;
   import net.wg.gui.events.SortingEvent;
   import net.wg.infrastructure.interfaces.IDAAPISortable;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class SortableTableList extends SortableScrollingList
   {
      
      private static const INV_SELECTED_RENDERER:String = 