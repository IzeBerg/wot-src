package net.wg.gui.lobby.profile.components.chart
{
   import flash.display.DisplayObject;
   import flash.events.Event;
   import net.wg.gui.lobby.profile.components.chart.layout.IChartLayout;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class ChartBase extends UIComponentEx
   {
      
      private static const RENDERER_CLASS_INV:String = 