package net.wg.gui.components.questProgress.components.headerProgress.solid
{
   import flash.display.Sprite;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BASE;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.gui.components.questProgress.components.headerProgress.HeaderProgressBase;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   
   public class HeaderProgressSolid extends HeaderProgressBase
   {
      
      private static const BG_HORIZONTAL_GAP:int = 28;
      
      private static const GREEN_HORIZONTAL_GAP:int = 10;
      
      private static const FILL_RIGHT_ADDITIONAL_WIDTH:int = 2;
       
      
      public var bg:Sprite = null;
      
      public var green:Sprite = null;
      
      public var bmFill:BitmapFill = null;
      
      private var _points:Vector.<FrameStateCmpnt> = null;
      
      public function HeaderProgressSolid()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.setBmFill();
      }
      
      override protected function onDataUpdate(param1:int, param2:IHeaderProgressData) : void
      {
         super.onDataUpdate(param1,param2);
         var _loc3_:Number = param1 / param2.goal;
         var _loc4_:int = _loc3_ * param2.value + FILL_RIGHT_ADDITIONAL_WIDTH;
         this.createPoints(param2.value,param2.goal,_loc3_);
         this.bg.width = param1 + BG_HORIZONTAL_GAP;
         this.green.width = _loc4_ + GREEN_HORIZONTAL_GAP;
         this.bmFill.widthFill = _loc4_;
         this.green.visible = this.bmFill.visible = Boolean(param2.value > 0);
      }
      
      override protected function onDispose() : void
      {
         this.clearPoints();
         this.bg = null;
         this.green = null;
         this.bmFill.dispose();
         this.bmFill = null;
         super.onDispose();
      }
      
      protected function setBmFill() : void
      {
         this.bmFill.source = QUEST_PROGRESS_BASE.HEADER_PROGRESS_BITMAP_FILL;
         this.bmFill.heightFill = QUEST_PROGRESS_BASE.HEADER_PROGRESS_BITMAP_FILL_HEIGHT;
         this.bmFill.repeat = BitmapFill.REPEAT_HORIZONTAL;
      }
      
      protected function createPoints(param1:int, param2:int, param3:Number) : void
      {
         this.clearPoints();
         this._points = new Vector.<FrameStateCmpnt>();
         var _loc4_:FrameStateCmpnt = null;
         var _loc5_:Number = param3;
         var _loc6_:String = Values.EMPTY_STR;
         var _loc7_:int = 1;
         while(_loc7_ < param2)
         {
            _loc4_ = this.getSeparator();
            this._points.push(_loc4_);
            _loc4_.x = _loc5_ ^ 0;
            this.addChild(_loc4_);
            if(_loc7_ < param1)
            {
               _loc6_ = QUEST_PROGRESS_BASE.PROGRESS_SOLID_POINT_STATE_PREV;
            }
            else if(_loc7_ > param1)
            {
               _loc6_ = QUEST_PROGRESS_BASE.PROGRESS_SOLID_POINT_STATE_NEXT;
            }
            else
            {
               _loc6_ = QUEST_PROGRESS_BASE.PROGRESS_SOLID_POINT_STATE_CURRENT;
            }
            _loc4_.frameLabel = _loc6_;
            _loc5_ += param3;
            _loc7_++;
         }
      }
      
      protected function getSeparator() : FrameStateCmpnt
      {
         return App.utils.classFactory.getComponent(QUEST_PROGRESS_BASE.PROGRESS_SOLID_SEPARATOR_CMPNT,FrameStateCmpnt);
      }
      
      private function clearPoints() : void
      {
         var _loc1_:FrameStateCmpnt = null;
         if(this._points)
         {
            for each(_loc1_ in this._points)
            {
               _loc1_.dispose();
               this.removeChild(_loc1_);
            }
            this._points.splice(0,this._points.length);
            this._points = null;
         }
      }
   }
}
