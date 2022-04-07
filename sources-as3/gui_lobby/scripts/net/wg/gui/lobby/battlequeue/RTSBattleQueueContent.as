package net.wg.gui.lobby.battlequeue
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.icons.BattleTypeIcon;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.data.DataProvider;
   
   public class RTSBattleQueueContent extends MovieClip implements IDisposable
   {
      
      private static const EVENT_1_VS_1_FRAME:String = "1vs1";
      
      private static const EVENT_1_VS_7_FRAME:String = "1vs7";
      
      private static const SMALL_POSTFIX:String = "_small";
       
      
      public var playersLabel:TextField;
      
      public var modeTitle:TextField;
      
      public var listByType:ScrollingListEx;
      
      public var battleIcon:BattleTypeIcon;
      
      public var battleIconBg:FrameStateCmpnt;
      
      public var footer:RTSBattleQueueFooter;
      
      public var sizeRect:MovieClip;
      
      private var _is1vs7:Boolean = false;
      
      private var _stageHeight:int = 0;
      
      private var _isDisposed:Boolean = false;
      
      public function RTSBattleQueueContent()
      {
         super();
         this.visible = false;
      }
      
      protected function onDispose() : void
      {
         this.playersLabel = null;
         this.modeTitle = null;
         this.listByType = null;
         this.battleIcon = null;
         this.battleIconBg = null;
         this.footer.dispose();
         this.footer = null;
         this.sizeRect = null;
      }
      
      public final function dispose() : void
      {
         this.onDispose();
         this._isDisposed = true;
      }
      
      public function setDP(param1:DataProvider) : void
      {
         this.visible = true;
         this._is1vs7 = param1.length > 1;
         this.listByType.dataProvider = param1;
         this.updateLayout();
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._stageHeight = param2;
         this.updateLayout();
      }
      
      private function updateLayout() : void
      {
         var _loc1_:String = !!this._is1vs7 ? EVENT_1_VS_7_FRAME : EVENT_1_VS_1_FRAME;
         if(this._stageHeight < StageSizeBoundaries.HEIGHT_800)
         {
            _loc1_ += SMALL_POSTFIX;
         }
         this.gotoAndStop(_loc1_);
      }
      
      override public function get width() : Number
      {
         return this.sizeRect.width;
      }
      
      override public function get height() : Number
      {
         return this.sizeRect.height;
      }
      
      public final function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
   }
}
