package net.wg.gui.lobby.profile.components
{
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.data.VO.AchievementItemVO;
   import net.wg.gui.components.controls.ResizableTileList;
   import net.wg.gui.components.controls.achievements.AchievementCommon;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.DirectionMode;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   
   public class AwardsTileListBlock extends UIComponentEx
   {
      
      protected static const DATA_PROVIDER_INV:String = "dpInv";
      
      protected static const LABEL_INV:String = "lblInv";
       
      
      public var textField:TextField;
      
      public var tileList:ResizableTileList;
      
      protected var _dataProvider:Array;
      
      private var _labelText:String = "";
      
      public function AwardsTileListBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(Event.RESIZE,this.tileResizeHandler,false,0,true);
         this.tileList.direction = DirectionMode.VERTICAL;
         this.tileList.columnCount = 12;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(DATA_PROVIDER_INV))
         {
            this.applyDataChanges();
         }
         if(isInvalid(LABEL_INV))
         {
            this.applyLabel();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.applySizeChanges();
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.tileList)
         {
            this.tileList.dispose();
            this.tileList = null;
         }
         if(this._dataProvider)
         {
            this._dataProvider = null;
         }
         super.onDispose();
      }
      
      public function invalidateDataProvider() : void
      {
         invalidate(DATA_PROVIDER_INV);
      }
      
      public function getRendererById(param1:String) : AchievementCommon
      {
         var _loc4_:AchievementCommon = null;
         var _loc2_:uint = this.tileList.getActualRenderersCount();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = AchievementCommon(this.tileList.getRendererAt(_loc3_));
            if(_loc4_ && _loc4_.data)
            {
               if(AchievementItemVO(_loc4_.data).name == param1)
               {
                  return _loc4_;
               }
            }
            _loc3_++;
         }
         return null;
      }
      
      protected function applyLabel() : void
      {
         this.textField.text = this._labelText;
      }
      
      protected function applySizeChanges() : void
      {
         _height = this.tileList.y + this.tileList.height;
      }
      
      protected function applyDataChanges() : void
      {
         this.tileList.dataProvider = new DataProvider(this._dataProvider);
         invalidate(LABEL_INV);
      }
      
      public function get dataProvider() : Array
      {
         return this._dataProvider;
      }
      
      public function set dataProvider(param1:Array) : void
      {
         this._dataProvider = param1;
         this.invalidateDataProvider();
      }
      
      public function get labelText() : String
      {
         return this._labelText;
      }
      
      public function set labelText(param1:String) : void
      {
         this._labelText = param1;
         invalidate(LABEL_INV);
      }
      
      private function tileResizeHandler(param1:Event) : void
      {
         this.applySizeChanges();
      }
   }
}
