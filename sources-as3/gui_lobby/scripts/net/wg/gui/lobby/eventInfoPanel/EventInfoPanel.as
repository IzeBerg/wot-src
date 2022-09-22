package net.wg.gui.lobby.eventInfoPanel
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelItemVO;
   import net.wg.gui.lobby.eventInfoPanel.data.EventInfoPanelVO;
   import net.wg.gui.lobby.eventInfoPanel.interfaces.IEventInfoPanel;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class EventInfoPanel extends UIComponentEx implements IEventInfoPanel
   {
      
      public static const HEIGHT_WITHOUT_SHADOW:int = 110;
       
      
      public var bg:UILoaderAlt;
      
      public var title1:TextField;
      
      public var description1:TextField;
      
      public var title2:TextField;
      
      public var description2:TextField;
      
      public var title3:TextField;
      
      public var description3:TextField;
      
      public var title4:TextField;
      
      public var description4:TextField;
      
      private var _data:EventInfoPanelVO;
      
      private var _titles:Vector.<TextField>;
      
      private var _description:Vector.<TextField>;
      
      public function EventInfoPanel()
      {
         super();
         this._titles = new <TextField>[this.title1,this.title2,this.title3,this.title4];
         this._description = new <TextField>[this.description1,this.description2,this.description3,this.description4];
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:EventInfoPanelItemVO = null;
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.bg.source = this._data.bgUrl;
            _loc1_ = this._description.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               _loc3_ = this._data.items[_loc2_];
               this._titles[_loc2_].htmlText = _loc3_.head;
               this._description[_loc2_].htmlText = _loc3_.descr;
               _loc2_++;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.bg.dispose();
         this.bg = null;
         this.title1 = null;
         this.description1 = null;
         this.title2 = null;
         this.description2 = null;
         this.title3 = null;
         this.description3 = null;
         this.title4 = null;
         this.description4 = null;
         this._titles.splice(0,this._titles.length);
         this._titles = null;
         this._description.splice(0,this._description.length);
         this._description = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         this._data = EventInfoPanelVO(param1);
         invalidateData();
      }
      
      public function get isEmptyData() : Boolean
      {
         return this._data == null;
      }
   }
}
