package net.wg.gui.lobby.epicBattles.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   
   public class EpicReservesPointsPanel extends Sprite implements IDisposable
   {
      
      private static const TF_ICON_GAP:uint = 2;
      
      private static const FONT_SIZE_SMALL:uint = 18;
      
      private static const FONT_SIZE_BIG:uint = 22;
      
      private static const LABEL_ICON_SMALL:String = "small";
      
      private static const LABEL_ICON_BIG:String = "big";
      
      private static const POINTS_TF_BIG_Y:uint = 4;
      
      private static const POINTS_TF_SMALL_Y:uint = 1;
      
      private static const POINTS_TF_BIG_X:uint = 20;
      
      private static const POINTS_TF_SMALL_X:uint = 8;
      
      private static const POINTS_ICON_BIG_Y:uint = 9;
      
      private static const POINTS_ICON_SMALL_Y:uint = 3;
       
      
      public var pointTf:TextField = null;
      
      public var pointIcon:MovieClip = null;
      
      public var bg:MovieClip = null;
      
      private var _pointValue:String = "";
      
      private var _isSmall:Boolean = false;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _commons:ICommons;
      
      private var _disposed:Boolean = false;
      
      public function EpicReservesPointsPanel()
      {
         this._tooltipMgr = App.toolTipMgr;
         this._commons = App.utils.commons;
         super();
         addEventListener(MouseEvent.ROLL_OUT,this.onReservesPanelRollOutHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onReservesPanelRollOverHandler);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.pointTf = null;
         this.pointIcon = null;
         removeEventListener(MouseEvent.ROLL_OUT,this.onReservesPanelRollOutHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onReservesPanelRollOverHandler);
         this.bg = null;
         this._tooltipMgr = null;
         this._commons = null;
      }
      
      public function setData(param1:String) : void
      {
         if(param1 == this._pointValue)
         {
            return;
         }
         this._pointValue = param1;
         this.pointTf.text = this._pointValue;
         this.updateSize(this._isSmall,true);
         this.updateLayout();
      }
      
      public function updateSize(param1:Boolean, param2:Boolean = false) : void
      {
         var _loc3_:TextFormat = null;
         if(this._isSmall != param1 || param2)
         {
            this._isSmall = param1;
            _loc3_ = this.pointTf.getTextFormat();
            _loc3_.size = !!this._isSmall ? FONT_SIZE_SMALL : FONT_SIZE_BIG;
            this.pointTf.setTextFormat(_loc3_);
            this.pointIcon.gotoAndStop(!!this._isSmall ? LABEL_ICON_SMALL : LABEL_ICON_BIG);
            this.bg.gotoAndStop(!!this._isSmall ? LABEL_ICON_SMALL : LABEL_ICON_BIG);
            this.updateLayout();
         }
      }
      
      private function updateLayout() : void
      {
         this._commons.updateTextFieldSize(this.pointTf,true,false);
         this.pointTf.x = !!this._isSmall ? Number(POINTS_TF_SMALL_X) : Number(POINTS_TF_BIG_X);
         this.pointTf.y = !!this._isSmall ? Number(POINTS_TF_SMALL_Y) : Number(POINTS_TF_BIG_Y);
         this.pointIcon.x = this.pointTf.x + this.pointTf.width + TF_ICON_GAP;
         this.pointIcon.y = !!this._isSmall ? Number(POINTS_ICON_SMALL_Y) : Number(POINTS_ICON_BIG_Y);
      }
      
      private function onReservesPanelRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onReservesPanelRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.showComplex(EPIC_BATTLE.EPICBATTLEITEM_SUPPLYPOINTS);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
