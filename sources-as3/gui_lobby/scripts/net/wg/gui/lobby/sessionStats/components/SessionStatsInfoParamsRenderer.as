package net.wg.gui.lobby.sessionStats.components
{
   import flash.display.Sprite;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.components.StatisticsDashLineTextItemIRenderer;
   import net.wg.gui.lobby.sessionStats.data.SessionBattleStatsRendererVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class SessionStatsInfoParamsRenderer extends Sprite implements IUpdatable, IDisposable
   {
      
      private static const LINES_WIDTH:int = 230;
      
      private static const ICON_X_POS:int = 217;
      
      private static const DASH_LINES_Y:Number = -1;
       
      
      public var difIcon:Image = null;
      
      public var dashLines:StatisticsDashLineTextItemIRenderer = null;
      
      private var _disposed:Boolean = false;
      
      public function SessionStatsInfoParamsRenderer()
      {
         super();
         this.dashLines = App.instance.utils.classFactory.getComponent(Linkages.SESSION_STATS_DASH_LINE_TEXT_ITEM_RENDERER_UI,StatisticsDashLineTextItemIRenderer);
         this.dashLines.y = DASH_LINES_Y;
         addChild(this.dashLines);
         this.dashLines.width = LINES_WIDTH;
         this.dashLines.useDefaultFormat = false;
         this.dashLines.bubblesSizeChanged = true;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.difIcon.dispose();
         this.difIcon = null;
         this.dashLines.dispose();
         this.dashLines = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:SessionBattleStatsRendererVO = SessionBattleStatsRendererVO(param1);
         this.dashLines.label = _loc2_.label;
         this.dashLines.value = _loc2_.value;
         if(_loc2_.delta)
         {
            this.difIcon.source = _loc2_.delta.icon;
            if(!this.hasValue)
            {
               this.difIcon.x = ICON_X_POS;
            }
         }
      }
      
      public function get hasValue() : Boolean
      {
         return StringUtils.isNotEmpty(this.dashLines.value);
      }
   }
}
