package net.wg.gui.lobby.missions.components
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.lobby.missions.components.headerComponents.HeaderDescBlock;
   import net.wg.gui.lobby.missions.data.MissionPackMarathonHeaderVO;
   import net.wg.gui.lobby.missions.interfaces.IMarathonHeaderBlock;
   import net.wg.infrastructure.interfaces.IImage;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class MissionPackMarathonHeader extends MissionPackHeaderBase
   {
      
      private static const BLOCKS_WIDTH:int = 300;
      
      private static const BLOCKS_Y:int = 103;
      
      private static const BLOCKS_GAP:int = 37;
      
      private static const BLOCKS_NUMBER:int = 3;
      
      private static const ARROWS_HEIGHT:int = 154;
      
      private static const ARROWS_Y_SHIFT:int = 4;
      
      private static const PADDING_BOTTOM:int = 25;
      
      private static const MIN_CONTENT_DIF:int = 20;
       
      
      public var descBlock:HeaderDescBlock;
      
      public var conditionBlock:IMarathonHeaderBlock;
      
      public var awardBlock:IMarathonHeaderBlock;
      
      public var arrow1:Sprite;
      
      public var arrow2:Sprite;
      
      public var uiDecoration:IImage = null;
      
      private var _lastHeight:int = 0;
      
      public function MissionPackMarathonHeader()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.conditionBlock.addEventListener(Event.RESIZE,this.onConditionBlockResizeHandler);
         this.uiDecoration.addEventListener(Event.CHANGE,this.onUiDecorationChangeHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:MissionPackMarathonHeaderVO = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         super.draw();
         if(data && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = MissionPackMarathonHeaderVO(data);
            this.descBlock.update(_loc1_.descBlockVO);
            this.descBlock.validateNow();
            this.conditionBlock.setData(_loc1_.conditionBlockVO);
            this.conditionBlock.validateNow();
            this.awardBlock.setData(_loc1_.awardBlockVO);
            this.awardBlock.validateNow();
            this.uiDecoration.visible = StringUtils.isNotEmpty(_loc1_.uiDecoration);
            if(this.uiDecoration.visible)
            {
               this.uiDecoration.source = _loc1_.uiDecoration;
            }
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.descBlock.x = width - BLOCKS_WIDTH * BLOCKS_NUMBER - BLOCKS_GAP * (BLOCKS_NUMBER - 1) >> 1;
            this.arrow1.x = this.descBlock.x + BLOCKS_WIDTH;
            this.conditionBlock.x = this.descBlock.x + BLOCKS_WIDTH + BLOCKS_GAP;
            this.arrow2.x = this.conditionBlock.x + BLOCKS_WIDTH;
            this.awardBlock.x = this.conditionBlock.x + BLOCKS_WIDTH + BLOCKS_GAP;
            _loc2_ = Math.max(this.conditionBlock.height,this.awardBlock.height);
            height = _loc2_ + BLOCKS_Y + PADDING_BOTTOM;
            this.arrow1.y = this.arrow2.y = (_loc2_ - ARROWS_HEIGHT >> 1) + BLOCKS_Y + ARROWS_Y_SHIFT;
            if(Math.abs(this.conditionBlock.contentHeight - this.awardBlock.contentHeight) > MIN_CONTENT_DIF)
            {
               _loc3_ = Math.max(this.conditionBlock.contentHeight,this.awardBlock.contentHeight);
               this.conditionBlock.setContentTopPadding(_loc3_ - this.conditionBlock.contentHeight >> 1);
               this.awardBlock.setContentTopPadding(_loc3_ - this.awardBlock.contentHeight >> 1);
            }
            if(this.uiDecoration.visible)
            {
               this.uiDecoration.x = width - this.uiDecoration.width >> 1;
            }
            if(height != this._lastHeight)
            {
               this._lastHeight = height;
               dispatchEvent(new Event(Event.RESIZE));
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.conditionBlock.removeEventListener(Event.RESIZE,this.onConditionBlockResizeHandler);
         this.descBlock.dispose();
         this.descBlock = null;
         this.conditionBlock.dispose();
         this.conditionBlock = null;
         this.awardBlock.dispose();
         this.awardBlock = null;
         this.uiDecoration.removeEventListener(Event.CHANGE,this.onUiDecorationChangeHandler);
         this.uiDecoration.dispose();
         this.uiDecoration = null;
         this.arrow1 = null;
         this.arrow2 = null;
         super.onDispose();
      }
      
      override protected function get dataClass() : Class
      {
         return MissionPackMarathonHeaderVO;
      }
      
      private function onConditionBlockResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onUiDecorationChangeHandler(param1:Event) : void
      {
         invalidateSize();
      }
   }
}
